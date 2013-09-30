// FanLib.scad - sizes/models for common computer fans.
// support file for http://www.thingiverse.com/thing:111187
function FanVersion() = 1.0;
echo("FanLib.FanVersion=",FanVersion());
/*
 * 
 * Data storage concept 
 *  from stepper.scad "A nema standard stepper motor module"
 *      Originally by Hans Häggström, 2010."
 *      distributed in MCAD Library of OpenSCAD
 * 
// =======================================================================
 * 
 * Fan data is referenced by FanModel
 * FanModel is either Fan<size> or where multiple thichnesses Fan<size><thick>
 * e.g. Fan60, Fan6025
 * See the data list below for the right FanModel
 * 
 * Fan data is retreived by FanDataNames - see list below - via the lookup() function 
 * data=lookup(FanDataName,FanModel);
 * e.g. screwRadius=lookup(FanScrewHoleDiameter,Fan90)/2;
 *      fanWide=lookup(FanSideSize,Fan60);
 * 
 * Modules
 * =======
 * Parameters: <optional>,  |=options, *=default option, default FanModel is Fan80
 * -----------------------------------------------------------------------------------------
 *  FanBody(<Fan=><FanModel><, FanDeep=0*|n><, FanHoles=true*|false><, FanSide=FanInlet*|FanOutlet>); 
 *  =======
 *      // Fan outline with screw holes and gap in middle where fan/motor goes.
 *      // Depth is based on model unless overridden by FanDeep=
 *      // Remove screw holes with FanHoles=false
 *      // The cutout is based on inlet model spec unless FanSide=FanOutlet (usually little difference)
 *      // Todo - a. grill, b. motor/fan, c. inlet/outlet size each side
 *  e.g.
 *  FanBody(Fan80); // vanila 80mm fan
 *  FanBody(Fan=Fan140,15,FanHoles=false,FanSide=FanOutlet);  
 *      // 140mm fan but 15mm deep, no holes, outlet cutout shape
 * 
 * -----------------------------------------------------------------------------------------
 * 	FanOutline(<Fan=><FanModel><, FanDeep=0*|n><, FanHoles=true*|false>); 
 *  ==========
 *      // draws the outline shape centered
 *      // difference() the holes by default, use FanHoles=false for just the outline
 *      // by default the fan model depth is used, this can be overridden by FanDeep= parameter
 *      // z has s (default 0.75) added to top/bottom face for clean difference()
 *      //    you can add a s= parameter to override this
 *  e.g. 
 *  FanOutline(Fan80,FanHoles=false); // outline no screw holes with 0.05 extra on each end of z
 * 
 * -----------------------------------------------------------------------------------------
 *  FanCutout(<Fan=><FanModel><, FanDeep=0*|n><, FanHoles=true*|false><, FanSide=FanInlet*|FanOutlet>);
 *  =========
 *      // Centered model to difference() a cutout where a fan will be mounted
 *      // Depth is based on model unless overridden by FanDeep=
 *      // Remove screw holes cutouts with FanHoles=false
 *      // The center cutout is based on inlet model spec unless FanSide=FanOutlet 
 *  e.g
 *  FanCutout(Fan=Fan40, FanSide=FanOutlet);
 *  //
 *  difference() {
 * 	  extratorDuct(200,200,450,2); // 200x200 duct 450 long 2mm thick
 * 	  translate([lookup(FanSideSize,Fan140)/2,lookup(FanSideSize,Fan140)/2,0])
 *      FanCutout(Fan140, FanDeep=3);
 *  }

 * ---------------------------------------------------------------------------------------------------
 *  FanScrewHoles(FanModel <,FanDeep=0>); // just the holes centered, ideal for difference() 
 *  =============
 * 		// by default the hole depth is sized to the fan model depth, 
 *      //    this can be overridden by FanDeep= parameter
 *      // z has s (default 0.75) added to top/bottom for clean difference() 
 * 		//    you can add a s= parameter to override this
 *  e.g.
 *  FanScrewHoles(Fan6025, FanDeep=5, s=0); 
 *      // 60mm fan 25mm thick, but only produce hole outlines 5mm deep
 * 
 * ---------------------------------------------------------------------------------------------------
 *  In all modules you can add a $fs (or other $variables) paramter to influence the curvature
 *  e.g. 
 *  FanOutline(Fan=Fan12025, $fs=0.01);  
 *      // outline with screw holes for 120mm fan 25mm thick, nicely rounded
 * 
 **
 */

/* ToDo 
 * Use inlet & outlet in body
 * Sizes 40/15,40/20,50/10,60/20,60/38,140,200,230
 
 * Models Under Construction/Incomplete*

Fan4015 = [
		];

 */


// =======================================================================

s=0.075;		// smidgen for difference()
mm=1;

// Note - apart from above, external facing variables/modules/parameters are in UpperCamelCase
//        inside modules local variables are lowerCamelCase



// Allow render() calls to be overridden by calling program, modules use FanRendIt(FanRender)
// false is speedier preview, but some things can look like crap
FanRender=true;		

// FanDataNames - sequential numbers MUST match order of fields on FanData below
// ============                      ====
FanModel=0;
FanSideSize=1;
FanHoleCenters=2;
FanScrewHoleDiameter=3;
FanFrontBack=4;
FanLayerThick=5;
CutoutSide=6;
CutoutInletDiameter=7;
CutoutOutletDiameter=8;
CutoutScrewHoleDiamter=9;
//
// Shorthand - used for simple module parameter calls
FanInlet=CutoutInletDiameter;
FanOutlet=CutoutOutletDiameter;
FanSS=FanSideSize;
FanSHD=FanScrewHoleDiameter;


// =======================================================================


// This FanData MUST be above modules and test code
//      ======= ====

// When adding a model add to the FanList variable at the end of the models below

// The following was collected by reviewing a bunch of datasheets,
//  different vendors use different measures, you can add your own if needed, here or in main calling module

Fan40 = [
			[FanModel, 40],
			[FanSideSize, 40*mm],
			[FanHoleCenters, 32*mm],
			[FanScrewHoleDiameter, 3.5*mm],
			[FanFrontBack, 10*mm],
			[FanLayerThick, 2*mm],
			[CutoutSide, 157*mm],
			[CutoutInletDiameter, 38*mm],//*
			[CutoutOutletDiameter, 40*mm],//*
			[CutoutScrewHoleDiamter, 3.7*mm]
		];
		
Fan50 = [
			[FanModel, 50],
			[FanSideSize, 50*mm],
			[FanHoleCenters, 42*mm],
			[FanScrewHoleDiameter, 4.2*mm],   // 3.7
			[FanFrontBack, 15*mm],
			[FanLayerThick, 2.5*mm],
			[CutoutSide, 157*mm],
			[CutoutInletDiameter, 48*mm],
			[CutoutOutletDiameter, 51*mm],
			[CutoutScrewHoleDiamter, 4.7*mm]
		];

Fan60 = [
			[FanModel, 60],
			[FanSideSize, 60*mm],
			[FanHoleCenters, 50*mm],
			[FanScrewHoleDiameter, 4.3*mm],
			[FanFrontBack, 15*mm],
			[FanLayerThick, 3*mm],
			[CutoutSide, 58*mm],
			[CutoutInletDiameter, 63*mm],
			[CutoutOutletDiameter, 63*mm],
			[CutoutScrewHoleDiamter, 4.7*mm]
		];
		
Fan6025 = [
			[FanModel, 6025],
			[FanSideSize, 60*mm],
			[FanHoleCenters, 50*mm],
			[FanScrewHoleDiameter, 4.3*mm],
			[FanFrontBack, 25*mm],
			[FanLayerThick, 3.5*mm],
			[CutoutSide, 59*mm],
			[CutoutInletDiameter, 62.7*mm],
			[CutoutOutletDiameter, 63*mm],
			[CutoutScrewHoleDiamter, 4.5*mm]
		];
		
Fan80 = [
			[FanModel, 80],
			[FanSideSize, 80*mm],
			[FanHoleCenters, 71.5*mm],
			[FanScrewHoleDiameter, 4.5*mm],
			[FanFrontBack, 25.5*mm],
			[FanLayerThick, 4*mm],
			[CutoutSide, 78*mm],
			[CutoutInletDiameter, 86*mm],
			[CutoutOutletDiameter, 92*mm],
			[CutoutScrewHoleDiamter, 4.7*mm]
		];
		
Fan90 = [
			[FanModel, 90],
			[FanSideSize, 92*mm],
			[FanHoleCenters, 82.5*mm],
			[FanScrewHoleDiameter, 4.5*mm],
			[FanFrontBack, 25.5*mm],
			[FanLayerThick, 4*mm],
			[CutoutSide, 88*mm], //*
			[CutoutInletDiameter, 100*mm],
			[CutoutOutletDiameter, 104*mm],
			[CutoutScrewHoleDiamter, 4.7*mm]
		];

Fan120 = [
			[FanModel, 120],
			[FanSideSize, 120*mm],
			[FanHoleCenters, 105*mm],
			[FanScrewHoleDiameter, 4.5*mm],
			[FanFrontBack, 25.5*mm],
			[FanLayerThick, 4*mm],
			[CutoutSide, 118*mm], //*
			[CutoutInletDiameter, 130*mm],
			[CutoutOutletDiameter, 132*mm],
			[CutoutScrewHoleDiamter, 4.7*mm]
		];
		
Fan12038 = [
			[FanModel, 12038],
			[FanSideSize, 120*mm],
			[FanHoleCenters, 105*mm],
			[FanScrewHoleDiameter, 4.5*mm],
			[FanFrontBack, 38*mm],
			[FanLayerThick, 6*mm],
			[CutoutSide, 118*mm], //*
			[CutoutInletDiameter, 130*mm],
			[CutoutOutletDiameter, 132*mm],
			[CutoutScrewHoleDiamter, 4.7*mm]
		];
		
Fan140 = [
			[FanModel, 140],
			[FanSideSize, 140*mm],
			[FanHoleCenters, 124.5*mm],
			[FanScrewHoleDiameter, 4.3*mm],
			[FanFrontBack, 25.5*mm],
			[FanLayerThick, 6*mm],
			[CutoutSide, 134*mm],
			[CutoutInletDiameter, 147*mm],
			[CutoutOutletDiameter, 149*mm],
			[CutoutScrewHoleDiamter, 4.5*mm]
		];		
		
Fan14038 = [
			[FanModel, 14038],
			[FanSideSize, 140*mm],
			[FanHoleCenters, 124.5*mm],
			[FanScrewHoleDiameter, 4.3*mm],
			[FanFrontBack, 38*mm],
			[FanLayerThick, 6*mm],
			[CutoutSide, 134*mm],
			[CutoutInletDiameter, 147*mm],
			[CutoutOutletDiameter, 149*mm],
			[CutoutScrewHoleDiamter, 4.5*mm]
		];		
		
Fan14051 = [
			[FanModel, 14051],
			[FanSideSize, 140*mm],
			[FanHoleCenters, 124.5*mm],
			[FanScrewHoleDiameter, 4.3*mm],
			[FanFrontBack, 51*mm],
			[FanLayerThick, 6*mm],
			[CutoutSide, 134*mm],
			[CutoutInletDiameter, 147*mm],
			[CutoutOutletDiameter, 149*mm],
			[CutoutScrewHoleDiamter, 4.5*mm]
		];		

Fan160 = [
			[FanModel, 160],
			[FanSideSize, 160*mm],
			[FanHoleCenters, 138.5*mm],
			[FanScrewHoleDiameter, 5.5*mm],
			[FanFrontBack, 51*mm],
			[FanLayerThick, 4*mm],
			[CutoutSide, 157*mm],
			[CutoutInletDiameter, 175*mm],
			[CutoutOutletDiameter, 175*mm],
			[CutoutScrewHoleDiamter, 5.7*mm]
		];		

// END FanData

// FanList is handy, e.g. allows test programs to step through all fans	
FanList =  [Fan40,Fan50,Fan60,Fan6025,Fan80,Fan120,Fan12038,Fan140,Fan14038,Fan14051,Fan160]; 


// =============================================================================

// Functions

// FanOffset - allows placement of fan from an edge (ie allowance for screw holes)
function FanOffset(Fan=Fan80) = (lookup(FanSideSize,Fan)-lookup(FanHoleCenters,Fan))/2;


// Modules
// =======================================================================
module FanBody(Fan=Fan80, FanDeep=0, FanHoles=true, FanSide=FanInlet) {
	// todo - use FanLayerThick to show covers, maybe fan blades?
	FanRendIt(FanRender)
		difference() {
			FanOutline(Fan, FanDeep, FanHoles, s=0, $fs=0.1);
			// -
			translate([0,0,0])
				FanCutout(Fan, FanDeep, FanHoles, FanSide);
		} // d
} // FanBody

// =======================================================================
module FanCutout(Fan=Fan80, FanDeep=0, FanHoles=true, FanSide=FanInlet) {
	s2=s*2; // locally define s2 so caller can change s as parameter if needed
	sl=0.1; // s-local, a smidgen to use here, not designed to be changed
	sl2=sl*2;
	// get data
	sideCut=lookup(CutoutSide,Fan);
	holeCutR=lookup(FanSide,Fan)/2;
	side=lookup(FanSideSize,Fan);
	holeC=lookup(FanHoleCenters,Fan);
	screwR=lookup(CutoutScrewHoleDiamter,Fan)/2+s;
	deep=(FanDeep==0 ? lookup(FanFrontBack,Fan) : FanDeep);
	// calcs
	holeOffset=(side-holeC)/2;
	// build
	FanRendIt(FanRender)
		translate([0,0,-s])
			intersection() {
				cube([sideCut,sideCut,deep+s2*1.5],center = true);
				cylinder(r=holeCutR,h=deep+s2*1.5,center = true);
			} // i
	if (FanHoles) {
		translate([0,0,-deep/2]) {
			translate([side/2-holeOffset,side/2-holeOffset,-s])
				cylinder(r=screwR,h=deep+s2);
			translate([-side/2+holeOffset,side/2-holeOffset,-s])
				cylinder(r=screwR,h=deep+s2);
			translate([side/2-holeOffset,-side/2+holeOffset,-s])
				cylinder(r=screwR,h=deep+s2);
			translate([-side/2+holeOffset,-side/2+holeOffset,-s])
				cylinder(r=screwR,h=deep+s2);
		} // t
	} // if
} // FanCutout

// =======================================================================
module FanOutline(Fan=Fan80, FanDeep=0, FanHoles=true) {
	s2=s*2; // locally define s2 so caller can change s as parameter if needed
	sl=0.1; // s-local, a smidgen to use here, not designed to be changed
	sl2=sl*2;
	// get data
	side=lookup(FanSideSize,Fan);
	holeC=lookup(FanHoleCenters,Fan);
	screwR=lookup(FanScrewHoleDiameter,Fan)/2;
	deep=(FanDeep==0 ? lookup(FanFrontBack,Fan) : FanDeep);
	// calcs
	outRadius=(side-holeC)/2;
	holeOffset=outRadius;
	// build
	FanRendIt(FanRender)
		difference() {
			roundedBox(side,side,deep+s2,outRadius);
			// -
			if (FanHoles) {
				translate([0,0,-deep/2]) {
					translate([side/2-holeOffset,side/2-holeOffset,-sl])
						cylinder(r=screwR,h=deep+sl2);
					translate([-side/2+holeOffset,side/2-holeOffset,-sl])
						cylinder(r=screwR,h=deep+sl2);
					translate([side/2-holeOffset,-side/2+holeOffset,-sl])
						cylinder(r=screwR,h=deep+sl2);
					translate([-side/2+holeOffset,-side/2+holeOffset,-sl])
						cylinder(r=screwR,h=deep+sl2);
				} // T
			} // if
		} // d
} // FanOutline

// =======================================================================
module FanScrewHoles(Fan=Fan80, FanDeep=0) {
	s2=s*2; // locally define s2 so caller can change s as parameter if needed
	// get data
	side=lookup(FanSideSize,Fan);
	holeC=lookup(FanHoleCenters,Fan);
	screwR=lookup(FanScrewHoleDiameter,Fan)/2;
	deep=(FanDeep==0 ? lookup(FanFrontBack,Fan) : FanDeep);
	// calcs
	outRadius=(side-holeC)/2;
	holeOffset=outRadius;
	// build
	translate([0,0,-deep/2]) {
		translate([side/2-holeOffset,side/2-holeOffset,-s])
			cylinder(r=screwR,h=deep+s2);
		translate([-side/2+holeOffset,side/2-holeOffset,-s])
			cylinder(r=screwR,h=deep+s2);
		translate([side/2-holeOffset,-side/2+holeOffset,-s])
			cylinder(r=screwR,h=deep+s2);
		translate([-side/2+holeOffset,-side/2+holeOffset,-s])
			cylinder(r=screwR,h=deep+s2);
	} // t
} // FanScrewHoles


// =======================================================================
// Support module, allows optional use of render()
// true produces cleaner preview, but is slow until cached, false is fast but some thing look bad.
module FanRendIt(FanRend=true) {
	if (FanRend)
		render()
			child(0);
	else 
		child(0);
}
// =======================================================================

module FanTesting() {
	
	// basic outline, imcludes holes
	FanOutline(FanTest);
	
	// just the holes, 5 thick, 0 extra z
	translate([0,0,FanTestZ*0.8])
		color(Aluminum)
			FanScrewHoles(Fan=FanTest, FanDeep=5, s=0);
			
	// thin outline with holes
	translate([0,0,FanTestZ*2])
		color(FiberBoard,0.33)
			FanOutline(FanTest, 1);
			
	// cutout outlet side, no holes
	translate([0,0,-FanTestZ*5])
		difference() {
			color(Stainless, 0.6) cube([FanTestWide*1.5,FanTestWide*1.5,2],center = true);
			FanCutout(FanTest, 3, FanHoles=false, FanSide=FanOutlet);
		}
		
	// cutout inlet side with holes		
	translate([0,0,-FanTestZ*4])
		difference() {
			color(Iron,0.6) cube([FanTestWide*1.5,FanTestWide*1.5,2],center = true);
			FanCutout(FanTest, 3, $fs=0.1);
		}
		
	// shell of the fan
	translate([0,0,-FanTestZ*2.8])
		color(Steel,0.8)
			FanBody(FanTest);
} // FanTesting	

// =======================================================================

// Test - must be below FanData
// ====

FanDebug=false;							// change to true for testing in this file
FanTest=Fan90;
FanTestZ=lookup(FanFrontBack,FanTest);
FanTestWide=lookup(FanSideSize,FanTest);

if (FanDebug==true) 
	FanTesting();

// =======================================================================
include <MCAD/shapes.scad>			// roundedbox() used in FanOutline()
include <MCAD/materials.scad>		// colours used in FanTesting()

// =======================================================================
