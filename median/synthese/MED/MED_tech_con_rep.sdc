###################################################################################
# Mentor Graphics Corporation
#
###################################################################################

#################
# Attributes
#################
set_attribute -name tap_distance -value "8" -instance -type integer ix2857z49990 -design gatelevel 
set_attribute -name number_of_taps -value "1" -instance -type integer ix2857z49990 -design gatelevel 
set_attribute -name width -value "8" -instance -type integer ix2857z49990 -design gatelevel 


##################
# Clocks
##################
create_clock { CLK } -domain ClockDomain0 -name CLK -period 20.000000 -waveform { 0.000000 10.000000 } -design gatelevel 
