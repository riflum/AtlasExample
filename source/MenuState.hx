package;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.system.layer.TileSheetData;
import org.flixel.plugin.texturepacker.TexturePackerData;

class MenuState extends FlxState
{
	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		FlxG.mouse.show();
		
		// TexturePackerData is a helper class to store links to atlas image and atlas data files
		var tex1 = new TexturePackerData("assets/test-trim-rotation.json", "assets/test-trim-rotation.png");
		var tex2 = new TexturePackerData("assets/test-rotation.json", "assets/test-rotation.png");
		var tex3 = new TexturePackerData("assets/test-trim.json", "assets/test-trim.png");
		var tex4 = new TexturePackerData("assets/test.json", "assets/test.png");
		var tex5 = new TexturePackerData("assets/anim-trim.json", "assets/anim-trim.png");
		
		// You can provide first frame to show (see last parameter in loadImageFromTexture() method)
		// Plus you can generate reversed sprites which is useful for animating character in games
		var x1:FlxSprite = new FlxSprite(20, 20);
		x1.loadImageFromTexture(tex1, true, false, "100px-1,202,0,200-Scythescraper.png");
		x1.facing = FlxObject.LEFT;
		x1.resetSizeFromFrame();
		add(x1);
		
		// You can load rotated image from atlas. It is very useful for flash target where drawing rotated graphics is very expensive
		var x2:FlxSprite = new FlxSprite(20, 200);
		x2.loadRotatedImageFromTexture(tex2, "100px-1,202,0,200-Scythescraper.png", 72, true, true);
		add(x2);
		
		// You can set sprite's frame by using image name in atlas
		var x3:FlxSprite = new FlxSprite(200, 20);
		x3.loadImageFromTexture(tex3, true);
		x3.frameName = "super_element_50px_0.png";
		x3.resetSizeFromFrame();	
		add(x3);
		
		// Animation samples:
		// There are new three methods for adding animation in sprite with TexturePackerData 
		// The old one is still working also
		
		// 1. The first one requires array with names of images from the atlas:
		var x5:FlxSprite = new FlxSprite(300, 20);
		x5.loadImageFromTexture(tex5);
		// Array with frame names in animation
		var names:Array<String> = new Array<String>();
		for (i in 0...20)
		{
			names.push("tiles-" + i + ".png");
		}
		
		x5.addAnimationByNamesFromTexture("Animation", names, 5);
		x5.play("Animation");
		add(x5);
		
		// 2. The second one requires three additional parameters: image name prefix, array of frame indicies and image name postfix
		var x6:FlxSprite = new FlxSprite(300, 200);
		x6.loadImageFromTexture(tex5);
		// Array with frame indicies in animation
		var indicies:Array<Int> = new Array<Int>();
		for (i in 0...20)
		{
			indicies.push(i);
		}
		
		x6.addAnimationByIndiciesFromTexture("Animation", "tiles-", indicies, ".png", 24);
		x6.play("Animation");
		add(x6);
		
		// And the third one requires only image name prefix and it will sort and add all frames with it to animation
		var x7:FlxSprite = new FlxSprite(120, 200);
		x7.loadImageFromTexture(tex5);
		x7.addAnimationByPrefixFromTexture("ani", "tiles-");
		x7.play("ani");
		add(x7);
	}
}
