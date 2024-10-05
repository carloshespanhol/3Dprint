;this is a manual bed leveling gcode

; if you are usins a print surface that is heat sensitive 
;lower the bed bofore using or risk melting the surface

;before we start lets home everything
G91 ; set reletive positioning
G0 Z5 E1000;lift z 5 mm
G28 ;home all axis
G90 ; back  to absolute positioning

;begin head placement for bed leveling
;corner 1 rough adjustment
G0 Z5 F5000 ;lifts Z for movement
G0 X20 Y10 F5000 ;puts extruder in front left corner
G0 Z0 F5000 ; lowers head for bed alignment
G4 S20 ;pause for 20 seconds

;corner 2 rough adjustment
G0 Z5 F5000 ; lifts Z for movement
G0 X210 Y10 F5000 ;puts extruder in front right corner
G0 Z0 F5000 ; lowers head for bed alignment
G4 S20 ;pause for 20 seconds

;corner 3 rough adjustment
G0 Z5 F5000 ; lifts motor for movement
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G0 Z0 F5000 ;lowers nozzle
G4 S20 ;pause for 20 seconds

;corner 4 rough adjustment
G0 Z5 F5000 ; lifts motor for movement
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G0 Z0 F5000 ;lowers nozzle
G4 S20 ;pause for 20 seconds

;fine leveling
;corner 1 fine adjustment
G0 Z5 F5000 ;lifts Z for movement
G0 X20 Y10 F5000 ;puts extruder in front left corner
G0 Z0 F5000 ; lowers nozzle
G4 S20 ;pause for 20 seconds

;corner 2 fine adjustment
G0 Z5 F5000 ; lifts Z for movement
G0 X210 Y10 F5000 ;puts extruder in front right corner
G0 Z0 F5000 ; lowers head for bed alignment
G4 S20 ;pause for 20 seconds

;corner 3 fine adjustment
G0 Z5 F5000 ; lifts motor for movement
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G0 Z0 F5000 ;lowers nozzle
G4 S20 ;pause for 20 seconds

;corner 4 fine adjustment
G0 Z5 F5000 ; lifts motor for movement
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G0 Z0 F5000 ;lowers nozzle
G4 S20 ;pause for 20 seconds

;checking
;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds

;corner 1 checking
G0 X20 Y10 F5000 ;puts extruder in front left corner
G4 S10 ;pause for 10 seconds

;corner 2 checking
G0 X210 Y10 F5000 ;puts extruder in front right corner
G4 S10 ;pause for 10 seconds

;corner 3 checking
G0 X210 Y200 F5000 ;puts nozzle near rear right corner
G4 S10 ;pause for 10 seconds

;corner 4 checking
G0 X20 Y200 F5000 ;puts nozzle near rear left corner
G4 S10 ;pause for 10 seconds