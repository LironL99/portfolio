# ========= Base Clock Definition =========
# Define a 100 MHz primary clock on top-level port 'clk' (10 ns period)
create_clock -name clk_main -period 10.000 [get_ports clk]

# ========= Clock Quality/Guardbands =========
# Conservative uncertainty to account for jitter/modeling (tune later if needed)
set_clock_uncertainty -setup 0.20 -from [get_clocks clk_main] -to [get_clocks clk_main]
set_clock_uncertainty -hold  0.05 -from [get_clocks clk_main] -to [get_clocks clk_main]

# ========= Asynchronous Reset =========
# Mark asynchronous reset paths as false for timing (adjust port name if needed)
# (This prevents meaningless violations through the async reset tree.)
set_false_path -from [get_ports reset_n]

# ========= Optional (comment-in if/when you model IO timing) =========
# Example virtual input/output delays relative to clk_main (edit values/ports):
# set_input_delay  -clock [get_clocks clk_main] 2.0 [get_ports {din[*]}]
# set_output_delay -clock [get_clocks clk_main] 2.0 [get_ports {dout[*]}]

# ========= Reporting Aids (optional helpers you can run in TimeQuest) =========
# report_clocks
# report_timing -setup -npaths 10 -detail full_path
# report_timing -hold  -npaths 10 -detail full_path
