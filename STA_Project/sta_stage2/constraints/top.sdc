# ========= Base Clock Definition =========
create_clock -name clk_main -period 10.000 [get_ports clk]

# ========= Clock Quality/Guardbands =========
set_clock_uncertainty -setup 0.20 -from [get_clocks clk_main] -to [get_clocks clk_main]
set_clock_uncertainty -hold  0.05 -from [get_clocks clk_main] -to [get_clocks clk_main]

# ========= Asynchronous Reset =========
set_false_path -from [get_ports reset_n]


# ---- Exclude the synthetic chain sink register (u_slow.y[*]) from timing ----
# This removes both mux arcs into y[*] (demo-friendly false-path).
set_false_path \
  -from [get_registers "*cnt_*"] \
  -to   [get_registers "false_path_chain:u_slow|y[*]"]