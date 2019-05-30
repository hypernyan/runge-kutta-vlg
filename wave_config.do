
onerror {resume}
quietly WaveActivateNextPane {} 0


add wave -noupdate -format analog-step -radix decimal -min -10.0 -max +10.0 -height 128 -color "Azure" tb/u
add wave -noupdate -format analog-step -radix decimal -min -10.0 -max +10.0 -height 128 -color "Azure" tb/u_r
add wave -noupdate -format analog-step -radix decimal -min -10.0 -max +10.0 -height 128 -color "Azure" tb/u_c
add wave -noupdate -format analog-step -radix decimal -min -10.0 -max +10.0 -height 128 -color "Azure" tb/u_l
add wave -noupdate -format analog-step -radix decimal -min -10.0 -max +10.0 -height 128 -color "Azure" tb/i
add wave -noupdate -format analog-step -radix decimal -min -1.0  -max +1.0  -height 32  -color "Azure" tb/u_err
add wave -noupdate -format analog-step -radix decimal -min -128  -max +128  -height 32                 tb/adc_code

add wave -noupdate -format Logic -radix hexadecimal  tb/adc_ovfl_pos
add wave -noupdate -format Logic -radix hexadecimal  tb/adc_ovfl_neg

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 201
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {20 us}
