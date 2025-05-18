//..............................................Program Counter..............................//

module program_counter(
    input clk,
    input rst,
    input enable,
    input [31:0] pc_in,
    output reg [31:0] pc_out
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_out <= 0;
        else if (enable)
            pc_out <= pc_in;

    end
endmodule

//............................................PC Adder .......................................//
module pc_adder(
    input [31:0] pc_in,       
    output reg [31:0] pc_next 
);

    always @(*) begin
        pc_next = pc_in + 4;  
    end

endmodule

//.........................................Instruction Memory................................//

module Instruction_Memory(rst, clk, read_address, instruction_out);

input rst, clk;
input [31:0] read_address;
output [31:0] instruction_out;
reg [31:0] I_Mem [127:0];  
integer k;
assign instruction_out = I_Mem[read_address];

always @(posedge clk or posedge rst)
begin
    if (rst) begin
        for (k = 0; k < 64; k = k + 1) begin 
            I_Mem[k] = 32'b00;  
        end
    end else begin
		// ==== DATA HAZARD: LW followed by dependent ADD ====
		I_Mem[4]  = 32'b00000000010000001010000110000011; // lw x3, 4(x1)      // x3 ← MEM[4]
		I_Mem[8]  = 32'b00000000001100010000001000110011; // add x4, x2, x3    // Data hazard: rs2 = x3
		I_Mem[12] = 32'b00000000010000000000001010010011; // addi x5, x0, 4    // Unrelated instruction

		// ==== CONTROL HAZARD: BEQ dependent on two immediates ====
		I_Mem[16] = 32'b00000000010100000000001000010011; // addi x4, x0, 5    // x4 ← 5
		I_Mem[20] = 32'b00000000010100000000001010010011; // addi x5, x0, 5    // x5 ← 5
		I_Mem[24] = 32'b00000000010100100000011001100011; // beq x4, x5, +12   // Should branch
		I_Mem[28] = 32'b00000000011100000000010000010011; // addi x8, x0, 7    // Skipped if branch taken
		I_Mem[32] = 32'b00000000100000000000010010010011; // addi x9, x0, 8    // Executed instead

		// ==== DATA HAZARD: ADD depends on previous ADDI values ====
		I_Mem[36] = 32'b00000000101000000000010100010011; // addi x10, x0, 10  // x10 ← 10
		I_Mem[40] = 32'b00000000010101010000010110110011; // add x11, x10, x5  // Depends on x10 and x5

		// ==== CONTROL HAZARD: BEQ comparing two immediates, no branch taken ====
		I_Mem[44] = 32'b00000000010100000000011000010011; // addi x12, x0, 5   // x12 ← 5
		I_Mem[48] = 32'b00000000011000000000011010010011; // addi x13, x0, 6   // x13 ← 6
		I_Mem[52] = 32'b00000000110101100000011001100011; // beq x12, x13, +12 // Should NOT branch
		I_Mem[56] = 32'b00000000111100000000100000010011; // addi x16, x0, 15  // Executed normally

		I_Mem[60] = 32'b00000000000000000000000000000000; // NOP

    end
end

endmodule

//................................................Register File............................................//

module Register_File(clk, rst, RegWrite,Rs1,Rs2, Rd,Write_data,read_data1, read_data2);

input clk, rst, RegWrite;
input [4:0] Rs1,Rs2, Rd;
input [31:0] Write_data;
output [31:0] read_data1, read_data2;

reg [31:0] Registers [31:0];

 initial begin
Registers[0] = 0;
Registers[1] = 0;  
Registers[2] = 15;  
Registers[3] = 0; 
Registers[4] = 0;   
Registers[5] = 0; 
Registers[6] = 0;    
Registers[7] = 0;
Registers[8] = 0;
Registers[9] = 0;
Registers[10] = 0;
Registers[11] = 0;
Registers[12] = 0;
Registers[13] = 0;
Registers[14] = 0;
Registers[15] = 0;
Registers[16] = 0;
Registers[17] = 0;
Registers[18] = 0;
Registers[19] = 0;
Registers[20] = 0;
Registers[21] = 0;
Registers[22] = 0;
Registers[23] = 0;
Registers[24] = 0;
Registers[25] = 0;
Registers[26] = 0;
Registers[27] = 0;
Registers[28] = 0;
Registers[29] = 0;
Registers[30] = 0;
Registers[31] = 0;
end

integer k;
always @(posedge clk) begin
if (rst) 
begin
      for (k = 0; k < 32; k = k + 1) begin
        Registers[k] = 32'b00;
      end
    end

    else if (RegWrite ) begin
      Registers[Rd] = Write_data;
    end
  end

  assign read_data1 = Registers[Rs1];
  assign read_data2 = Registers[Rs2];
endmodule


//............................................Main Control Unit...............................................//

module main_control_unit(
    input [6:0] opcode,          
    output reg RegWrite,         
    output reg MemRead,          
    output reg MemWrite,         
    output reg MemToReg,        
    output reg ALUSrc,                      
    output reg Branch,                        
    output reg [1:0] ALUOp       
);

    always @(*) begin
        case (opcode)
            7'b0110011:  // R-type 
            begin  {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};end
            7'b0010011:   // I-type
            begin {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};end
            7'b0000011:   // Load 
            begin {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00};end
            7'b0100011:   // Store 
            begin {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00};end
            7'b1100011:   // Branch 
            begin {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11};end  
            7'b1101111:   // Jump 
            begin  {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};end
            7'b0110111:   // LUI
            begin {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};end
            default: 
            begin {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};end  
        endcase
    end

endmodule
//......................................................Immediate Generator..........................//

module immediate_generator(
    input [31:0] instruction,    
    output reg [31:0] imm_out   
);

    always @(*) begin
        case (instruction[6:0]) 
			7'b0010011: imm_out = {{20{instruction[31]}}, instruction[31:20]}; // I-type  
            7'b0000011: imm_out = {{20{instruction[31]}}, instruction[31:20]}; // Load-type
            7'b0100011: imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // Store-type
            7'b1100011: imm_out = {{19{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // B-type 
            7'b0110111: imm_out = {instruction[31:12], 12'b0}; // U-type
			7'b0010111: imm_out = {instruction[31:12], 12'b0}; // U-type 
            7'b1101111: imm_out = {{11{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // J-type
 
            default: imm_out = 32'b0; // Default case
        endcase
    end

endmodule

//.........................................................ALU.............................................//
module ALU(
    input [31:0] A,             
    input [31:0] B,            
    input [3:0] ALUcontrol_In,          
    output reg [31:0] Result,   
    output reg Zero             
);

    always @(A or B or ALUcontrol_In) begin
        case (ALUcontrol_In)
            4'b0000: Result = A + B;           		// ADD
            4'b0001: Result = A - B;           		// SUB
            4'b0010: Result = A & B;           		// AND
            4'b0011: Result = A | B;           		// OR
            4'b0100: Result = A ^ B;           		// XOR
            4'b0101: Result = A << B[4:0];     		// SLL (Shift Left Logical)
            4'b0110: Result = A >> B[4:0];     		// SRL (Shift Right Logical)
            4'b0111: Result = $signed(A) >>> B[4:0];    // SRA (Shift Right Arithmetic)
            4'b1000: Result =($signed(A) < $signed(B)) ? 32'b1 : 32'b0; // SLT (Set Less Than)
            default: Result = 32'b0;          		
        endcase

        case (ALUcontrol_In)
            4'b1000: Zero = (Result == 32'b1) ? 1 : 0; // SLT (Set Less Than)
            default: Zero = (Result == 32'b0) ? 1 : 0;          		
        endcase
        
    end

endmodule

//..............................................ALU Control...................................................//
module ALU_Control(        
    input [2:0] funct3,         
    input [6:0]funct7,        
    input [1:0] ALUOp,          
    output reg [3:0] ALUcontrol_Out 
);
always @(*) begin
  casex ({ALUOp, funct7, funct3})

  // I-type instructions:
  12'b10_xxxxxxx_000 : ALUcontrol_Out <= 4'b0000;    // ADDI
  12'b10_xxxxxxx_010 : ALUcontrol_Out <= 4'b1000;    // SLTI
  12'b10_xxxxxxx_111 : ALUcontrol_Out <= 4'b0010;    // ANDI
  12'b10_xxxxxxx_110 : ALUcontrol_Out <= 4'b0011;    // ORI
  12'b10_xxxxxxx_100 : ALUcontrol_Out <= 4'b0100;    // XORI
  12'b10_0000000_001 : ALUcontrol_Out <= 4'b0101;    // SLLI
  12'b10_0000000_101 : ALUcontrol_Out <= 4'b0110;    // SRLI
  12'b10_0100000_101 : ALUcontrol_Out <= 4'b0111;    // SRAI

  // R-type instructions:
  12'b10_0000000_000 : ALUcontrol_Out <= 4'b0000;    // ADD
  12'b10_0100000_000 : ALUcontrol_Out <= 4'b0001;    // SUB
  12'b10_0000000_111 : ALUcontrol_Out <= 4'b0010;    // AND
  12'b10_0000000_110 : ALUcontrol_Out <= 4'b0011;    // OR
  12'b10_0000000_100 : ALUcontrol_Out <= 4'b0100;    // XOR
  12'b10_0000000_001 : ALUcontrol_Out <= 4'b0101;    // SLL
  12'b10_0000000_101 : ALUcontrol_Out <= 4'b0110;    // SRL
  12'b10_0100000_101 : ALUcontrol_Out <= 4'b0111;    // SRA
  12'b10_0000000_010 : ALUcontrol_Out <= 4'b1000;    // SLT
  
  12'b00_xxxxxxx_xxx : ALUcontrol_Out <= 4'b0000;    // Load/store
  
  // Branch instructions:
  12'b11_0000000_000 : ALUcontrol_Out <= 4'b0001;    // BEQ
  12'b11_0000000_100 : ALUcontrol_Out <= 4'b1000;    // BLT → SLT
  
  default: ALUcontrol_Out <= 4'b0000;
endcase

end


endmodule

//................................................AND Logic......................................//
module AND_logic (
    input branch,   
    input zero,
	input [1:0] ALUOp,
    output and_out   
);

    assign and_out = branch & zero;
  

endmodule

//................................................ALU Mux(2x1)......................................//
module Mux1 (
    input [31:0] A1,   
    input [31:0] B1,   
    input select1,          
    output [31:0] Mux1_out      
);

    assign Mux1_out = (select1) ? B1 : A1;  

endmodule

//................................................Branch Mux(2x1)......................................//
module Mux2 (
    input [31:0] A2,   
    input [31:0] B2,   
    input select2,          
    output [31:0] Mux2_out      
);

    assign Mux2_out = (select2) ? B2 : A2;  

endmodule

//................................................Data Mem Mux(2x1)......................................//
module Mux3 (
    input [31:0] A3,   
    input [31:0] B3,   
    input select3,          
    output [31:0] Mux3_out      
);

    assign Mux3_out = (select3) ? B3 : A3;  

endmodule
//................................................Data Memory......................................//

module Data_Memory(
    input clk,               
    input rst,               
    input MemRead,           
    input MemWrite,          
    input [31:0] address,    
    input [31:0] write_data, 
    output[31:0] read_data 
);
  reg [31:0] D_Memory [63:0];

  integer k;

  assign read_data = (MemRead) ? D_Memory[address] : 32'b00;

  always @(posedge clk) begin
	D_Memory[4] = 99;

end 

  always @(posedge clk or posedge rst) begin
    if (rst ) begin
      for (k = 0; k < 64; k = k + 1) begin
        D_Memory[k] = 32'b00;
      end
    end else if (MemWrite) begin
      D_Memory[address] = write_data;
    end
  end

endmodule


//.............................................Branch Adder...................................//

module Branch_Adder(
    input [31:0] PC,                    
    input [31:0] offset,                 
    output reg [31:0] branch_target     
);

    always @(*) begin
        branch_target <= PC + offset;  
    end

endmodule

