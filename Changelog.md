Changes from BRTrains2 Baseline as of 15 Feb 2026



0030 26/02/2026



Class 755 rework

* Added multiple working/reversing to class 755
* Added unique reversed templates for 755/766 due to differing car lengths - needed to tune alignment while reversed.





1700 22/02/2026



Class 710

* Consolidated Class 710 /1, /2, and /3 into a single file: 710.pnml.
* Removed old split files (710-1.pnml, 710-2\_4car.pnml, 710-3\_5car.pnml) and 710.pnml.
* Added mixed-length multiple working reverse logic so 4-car and 5-car units reverse correctly when coupled together.
* Added clear step-by-step comments for the MW/reversing selector chain.



New Parameter

* Added GRF-wide parameter param\_standing\_capacity (default off) in grf.pnml.
* Added parameter strings in grf\_parameters.plng (Standing Room Mode and on/off options).
* Parameter is designed to allow higher standing-capacity values on selected units, independent of the global pax multiplier setting.



Class 717

* Reworked Class 717 into a single-ID articulated definition in BR717.pnml.
* Added positional sprite selection and push-pull reversing logic.
* Added per-car capacity switch logic supporting both seated total (362) and standing room total (943), before param\_pax multiplier.
* Added/updated purchase text capacity strings, as the default cargo capacity row in the purchase menu will only show a multiple of the number of cars for single-ID articulated vehicles.
* Added sprite sheet asset: Desiro\_City\_WIP.png.





0300 21/02/2026

Class 720 cleanup and documentation pass

* Merged Class 720 sprite and selector logic back into `electric\\\_mu/720.pnml` (single-file format).
* Retained mirrored multiple-working reverse logic for stable car roles across coupled units.
* Expanded Class 720 purchase text to include multiple-working/livery information.
* Reworked Class 720 comments to explain the runtime selector chain for new contributors.

Build order changes

* Changed build order to reduce concurrent spritegroup count, now 141/256
* Created new prepended file for switches that are called by units of multiple modes (Multimode\_MU, Electric\_mu, etc) to avoid build order issues.









0400 20/02/2026

Test of translator wagon and associated logic

* Added prototype BR Mk2 Translator Wagon (placeholder using Mk2 BSO sprites/liveries).
* Class 350 now detects translator wagons anywhere in consist and disables power, tractive effort, passenger capacity, sounds, and visual effects when present. (experimental)
* Class 350/1 dual-voltage effect logic updated: third-rail effect on THIRD, overhead spark effect when ELRL is available (including dual-voltage track).





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

