Changes from BRTrains2 Baseline as of 15 Feb 2026



0100 19/02/2026

Added Class 185multiple working and reversing

* Reworked Class 185 file into new file structure with split vehicle ID and spritegroup/reversing code files
* Moved Class 185 to Desire group. 
* Desiro family has now been completely moved to new file structure and has reversing sprites with realistic multiple working restrictions



2330 17/02/2026

Added class 444/450 multiple working and reversing

* Reworked Class 444 and Class 450 push-pull sprite logic into a unified switch file.
* Fixed mixed-class multiple-working reversal behavior for all tested consist orders.
* Preserved same-class multiple-working behavior for both Class 444 and Class 450.



2000 17/02/2026

Class 360 has been consolidated into a single definition file with updated comments and car-role structure.

Class 360/1 and 360/2 now use the shared mirrored push-pull/multiple-working setup.

Class 360/2 panto car placement is corrected to the second vehicle when facing forward (both 4-car and 5-car).

Purchase menu now supports a new multiple-working note: “Within subclass”.







Reworked Class 350 for multiple working (push-pull).

Split Class 350 into /1, /2, and /3/4 subclasses with appropriate livery restrictions and introduction dates.

Made Class 350/1 dual voltage (25kv AC/750v DC).

Reworked Class 380 for multiple working.

Reworked Class 357 for multiple working.

Split Class 357 into /0, /2, and /3 subclasses. Livery restrictions TBD.

Adjusted pax capacity for Class 357/3 to reflect 2+2 seating, verses 3+2 for rest of class.

Added Variant Header "Desiro" and grouped 350 and 380 into it. 

Added string to explain multiple working restrictions in purchase menu. Currently only option is "Within class", as all reworked units currently only work within class.

Moved Class 357 panto to 3rd car counting from A cab

