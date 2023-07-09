@ECHO OFF
"C:\Program Files (x86)\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "D:\amir-saeed\J3\J3-int\labels.tmp" -fI -W+ie -C V3 -o "D:\amir-saeed\J3\J3-int\J3-int.hex" -d "D:\amir-saeed\J3\J3-int\J3-int.obj" -e "D:\amir-saeed\J3\J3-int\J3-int.eep" -m "D:\amir-saeed\J3\J3-int\J3-int.map" "D:\amir-saeed\J3\J3-int\J3-int.asm"
