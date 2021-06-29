
##########
# Clocks #
##########
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

###############
# Input Delay #
###############
set_input_delay -clock clk -add_delay 0.000 [get_ports {rst req_ard ack_ard ct_valid data_in led_out*}]

################
# Output Delay #
################
set_output_delay -clock clk -add_delay 0.000 [get_ports {ack_bas req_bas ct_out data_to_led*}]

##############################
# Pin Locations and Voltages #
##############################
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports clk]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports req_ard]
set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVCMOS33} [get_ports ack_bas]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports data_in]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports req_bas]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports ack_ard]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports ct_out]
set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports ct_valid]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {data_to_led[0]}]
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {data_to_led[1]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {data_to_led[2]}]
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {data_to_led[3]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {data_to_led[4]}]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {data_to_led[5]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {data_to_led[6]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {data_to_led[7]}]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {data_to_led[8]}]
set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports {data_to_led[9]}]
set_property -dict {PACKAGE_PIN W3 IOSTANDARD LVCMOS33} [get_ports {data_to_led[10]}]
set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {data_to_led[11]}]
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {data_to_led[12]}]
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {data_to_led[13]}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {data_to_led[14]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {data_to_led[15]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {led_out[7]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {led_out[6]}]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {led_out[5]}]
set_property -dict {PACKAGE_PIN W2 IOSTANDARD LVCMOS33} [get_ports {led_out[4]}]
set_property -dict {PACKAGE_PIN R3 IOSTANDARD LVCMOS33} [get_ports {led_out[3]}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {led_out[2]}]
set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {led_out[1]}]
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {led_out[0]}]





##########################
# Configuration Settings #
##########################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]



