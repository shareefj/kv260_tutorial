# ----------------------------------------------------------------------
# Fan Speed Enable
# ----------------------------------------------------------------------

set_property PACKAGE_PIN A12 [get_ports {fan_en_b}]
set_property IOSTANDARD LVCMOS33 [get_ports {fan_en_b}]
set_property SLEW SLOW [get_ports {fan_en_b}]
set_property DRIVE 4 [get_ports {fan_en_b}]

# ----------------------------------------------------------------------
# PMOD
# ----------------------------------------------------------------------
# The PMOD interface on the KV260 is a 12 pin female connector. The PMOD
# spec defines the pin numbering as top to bottom with pin 1 on the inside
# of the PCB (i.e. when mated, pins 1-6 are on the outside of the connectors).
# However, the KV260 schematic has the connector numbered as a standard
# header which is slightly confusing.  The follow diagram replaces that
# from the schematic with the correct pin numbering:
#
#             +-----+------+
#     HDA_11  |  1  |   7  |  HDA_15
#             +-----+------+
#     HDA_12  |  2  |   8  |  HDA_16_CC
#             +-----+------+
#     HDA_13  |  3  |   9  |  HDA_17
#             +-----+------+
#     HDA_14  |  4  |  10  |  HDA_18
#             +-----+------+
#        GND  |  5  |  11  |  GND
#             +-----+------+
#        3V3  |  6  |  12  |  3V3
#             +-----+------+
#
# The corresponding package pin number can be matched against the HDA_
# port names from the SOM XDC:
#
#     Net Name    SOM240_1 Pin   Package Pin
#     HDA_11      A17            H12
#     HDA_12      D20            E10
#     HDA_13      D21            D10
#     HDA_14      D22            C11
#     HDA_15      B20            B10
#     HDA_16_CC   B21            E12
#     HDA_17      B22            D11
#     HDA_18      C22            B11
#
# ----------------------------------------------------------------------

set_property PACKAGE_PIN H12     [get_ports {pmod[0]}] ;# PMOD pin 1
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[0]}]

set_property PACKAGE_PIN E10     [get_ports {pmod[1]}] ;# PMOD pin 2
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[1]}]

set_property PACKAGE_PIN D10     [get_ports {pmod[2]}] ;# PMOD pin 3
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[2]}]

set_property PACKAGE_PIN C11     [get_ports {pmod[3]}] ;# PMOD pin 4
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[3]}]

set_property PACKAGE_PIN B10     [get_ports {pmod[4]}] ;# PMOD pin 7
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[4]}]

set_property PACKAGE_PIN E12     [get_ports {pmod[5]}] ;# PMOD pin 8
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[5]}]

set_property PACKAGE_PIN D11     [get_ports {pmod[6]}] ;# PMOD pin 9
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[6]}]

set_property PACKAGE_PIN B11     [get_ports {pmod[7]}] ;# PMOD pin 10
set_property IOSTANDARD LVCMOS33 [get_ports {pmod[7]}]


