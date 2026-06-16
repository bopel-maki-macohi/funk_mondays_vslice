import flixel.FlxG;
import flixel.FlxSprite;
import funkin.play.PlayState;
import funkin.mobile.input.ControlsHandler;
#if mobile
import funkin.mobile.ui.FunkinHitbox.FunkinHitboxControlSchemes;
#end
import funkin.Highscore;
import flixel.text.FlxBitmapText;
import flixel.text.FlxBitmapFont;

class MondayUI
{
	public static var isDownscroll(get, never):Bool;

	public static var missesText:FlxBitmapText = null;
	public static var comboText:FlxBitmapText = null;

	static function get_isDownscroll():Bool
	{
		return #if mobile (Preferences.controlsScheme == Arrows && !ControlsHandler.hasExternalInputDevice) || #end Preferences.downscroll;
	}

	public static function scoreUpdate()
	{
		if (missesText == null)
			return;

		missesText.text = 'Combo Breaks: ${Highscore.tallies.bad + Highscore.tallies.shit + Highscore.tallies.missed}';
		comboText.text = 'Combo: ${Highscore.tallies.combo} (Max: ${Highscore.tallies.maxCombo})';

		comboText.x = FlxG.width - comboText.width - 8;
		comboText.y = (!isDownscroll) ? FlxG.height - comboText.height - 8 : 8 + missesText.height + comboText.height;

		missesText.x = FlxG.width - missesText.width - 8;
		missesText.y = (!isDownscroll) ? comboText.y - missesText.height : 8 + missesText.height;

		PlayState.instance.scoreText.x = FlxG.width - PlayState.instance.scoreText.width - 8;
		PlayState.instance.scoreText.y = (!isDownscroll) ? missesText.y - missesText.height : 8;
	}

	public static function camInit(startCamOffsets:Array<Float>, zoomOffset:Float)
	{
		if (PlayState.instance.currentStage != null)
		{
			var gfPoint = PlayState.instance.currentStage.getGirlfriend().cameraFocusPoint;

			PlayState.instance.cameraFollowPoint.x = gfPoint.x + startCamOffsets[0];
			PlayState.instance.cameraFollowPoint.y = gfPoint.y + startCamOffsets[1];
			PlayState.instance.tweenCameraToFollowPoint(0);

			PlayState.instance.currentCameraZoom = PlayState.instance.currentStage.camZoom + zoomOffset;
			FlxG.camera.zoom = PlayState.instance.currentCameraZoom;
		}
	}

	public static function uiInit()
	{
		PlayState.instance.healthBarBG.visible = false;
		PlayState.instance.healthBar.visible = false;

		if (PlayState.instance.iconP1 != null)
			PlayState.instance.iconP1.visible = false;

		if (PlayState.instance.iconP2 != null)
			PlayState.instance.iconP2.visible = false;

		PlayState.instance.scoreText.zIndex *= 2;

		PlayState.instance.scoreText.antialiasing = false;
		PlayState.instance.scoreText.scale.set(2, 2);
		// PlayState.instance.scoreText.borderSize *= 2;

		PlayState.instance.comboPopUps.offsets = [400, (isDownscroll) ? 350 : -200];
		PlayState.instance.remove(PlayState.instance.comboPopUps);

		var opponentStrumline:FlxSprite = PlayState.instance.opponentStrumline;
		if (opponentStrumline != null)
			for (arrow in opponentStrumline.members)
				arrow.visible = false;

		if (Preferences.controlsScheme == "Arrows" && !ControlsHandler.usingExternalInputDevice)
			return;

		var playerStrumline:FlxSprite = PlayState.instance.playerStrumline;
		if (playerStrumline != null)
			playerStrumline.x = FlxG.width / 2 - playerStrumline.width / 2;

		missesText = makeExtraUIText(missesText);
		comboText = makeExtraUIText(comboText);

		PlayState.instance.add(missesText);
		PlayState.instance.add(comboText);
		PlayState.instance.refresh();
	}

	static function makeExtraUIText(baseText:FlxBitmapText)
	{
		var newText = baseText;

		if (newText != null)
		{
			PlayState.instance.remove(newText);
			newText.destroy();
			newText = null;
		}

		newText = new FlxBitmapText(0, 0, '', FlxBitmapFont.fromAngelCode(Paths.font("vcr-bmp.png"), Paths.font("vcr-bmp.fnt")));
		newText.alignment = PlayState.instance.scoreText.alignment;
		newText.borderStyle = PlayState.instance.scoreText.borderStyle;
		newText.borderColor = PlayState.instance.scoreText.borderColor;
		newText.letterSpacing = PlayState.instance.scoreText.letterSpacing;
		newText.scrollFactor = PlayState.instance.scoreText.scrollFactor;
		newText.scale.set(2, 2);
		newText.cameras = PlayState.instance.scoreText.cameras;
		newText.wordWrap = PlayState.instance.scoreText.wordWrap;
		newText.antialiasing = PlayState.instance.scoreText.antialiasing;
		newText.zIndex = PlayState.instance.scoreText.zIndex + 1;

		return newText;
	}
}
