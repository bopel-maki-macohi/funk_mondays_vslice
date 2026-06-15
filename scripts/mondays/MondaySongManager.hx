package mondays;

import funkin.play.PlayState;
import flixel.FlxSprite;
import funkin.mobile.input.ControlsHandler;

class MondaySongManager
{
	public static function songStuffs()
	{
		PlayState.instance.comboPopUps.offsets = [510, 320];

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
