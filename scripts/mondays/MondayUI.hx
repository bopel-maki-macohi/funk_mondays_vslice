package mondays;

import flixel.FlxG;
import flixel.FlxSprite;
import funkin.play.PlayState;
import funkin.mobile.input.ControlsHandler;

#if mobile
import funkin.mobile.ui.FunkinHitbox.FunkinHitboxControlSchemes;
#end

class MondayUI
{
	public static var isDownscroll(get, never):Bool;
	
	static function get_isDownscroll():Bool {
		return #if mobile (Preferences.controlsScheme == Arrows
			&& !ControlsHandler.hasExternalInputDevice)
			|| #end Preferences.downscroll;
	}
	
	public static function scoreUpdate()
	{
		PlayState.instance.scoreText.screenCenter();
		PlayState.instance.scoreText.y = (isDownscroll) ? FlxG.height - PlayState.instance.scoreText.height - 8 : 8;
	}

	public static function uiInit()
	{
		PlayState.instance.healthBarBG.visible = false;
		PlayState.instance.healthBar.visible = false;
		PlayState.instance.iconP1.visible = false;
		PlayState.instance.iconP2.visible = false;

		PlayState.instance.scoreText.zIndex *= 2;

		// PlayState.instance.scoreText.antialiasing = false;
		PlayState.instance.scoreText.scale.set(2, 2);
		// PlayState.instance.scoreText.borderSize *= 2;

		PlayState.instance.comboPopUps.offsets = [400, (isDownscroll) ? 350 : -200];

		var opponentStrumline:FlxSprite = PlayState.instance.opponentStrumline;
		if (opponentStrumline != null)
		{
			for (arrow in opponentStrumline.members)
				arrow.visible = false;
		}

		if (Preferences.controlsScheme == "Arrows" && !ControlsHandler.usingExternalInputDevice)
			return;

		var playerStrumline:FlxSprite = PlayState.instance.playerStrumline;
		if (playerStrumline != null)
		{
			playerStrumline.x = FlxG.width / 2 - playerStrumline.width / 2;
		}
	}
}
