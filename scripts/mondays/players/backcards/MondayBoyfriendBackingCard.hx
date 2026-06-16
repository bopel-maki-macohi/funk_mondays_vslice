import funkin.ui.freeplay.BGScrollingText;
import funkin.ui.freeplay.FreeplayState;
import funkin.ui.freeplay.backcards.BackingCard;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import funkin.ui.freeplay.charselect.PlayableCharacter;
import funkin.data.freeplay.player.PlayerRegistry;
import funkin.Conductor;

class MondayBoyfriendBackingCard extends BackingCard
{
	public var funnyScroll:BGScrollingText;
	public var funnyScroll2:BGScrollingText;
	public var funnyScroll3:BGScrollingText;

	var glow:FlxSprite;
	var glowDark:FlxSprite;

	public override function applyExitMovers(?exitMovers:FreeplayState.ExitMoverData, ?exitMoversCharSel:FreeplayState.ExitMoverData):Void
	{
		super.applyExitMovers(exitMovers, exitMoversCharSel);
		if (exitMovers == null || exitMoversCharSel == null)
			return;
		exitMovers.set([funnyScroll], {
			x: -funnyScroll.width * 2,
			y: funnyScroll.y,
			speed: 0.4,
			wait: 0
		});
		exitMovers.set([funnyScroll2], {
			x: -funnyScroll2.width * 2,
			speed: 0.5,
		});
		exitMovers.set([funnyScroll3], {
			x: -funnyScroll3.width * 2,
			speed: 0.3
		});

		exitMoversCharSel.set([funnyScroll, funnyScroll2, funnyScroll3], {
			y: -60,
			speed: 0.8,
			wait: 0.1
		});
	}

	public override function enterCharSel():Void
	{
		FlxTween.tween(funnyScroll, {speed: 0}, 0.8, {ease: FlxEase.sineIn});
		FlxTween.tween(funnyScroll2, {speed: 0}, 0.8, {ease: FlxEase.sineIn});
		FlxTween.tween(funnyScroll3, {speed: 0}, 0.8, {ease: FlxEase.sineIn});
	}

	public override function new()
	{
		super("monday-boy");

		var player = PlayerRegistry.instance.fetchEntry(this.currentCharacter);
		funnyScroll = new BGScrollingText(120, 220, player.getFreeplayDJText(1), FlxG.width / 2, true, 80);
		funnyScroll2 = new BGScrollingText(0, 340, player.getFreeplayDJText(2), FlxG.width / 2, true, 80);
		funnyScroll3 = new BGScrollingText(0, 460, player.getFreeplayDJText(3), FlxG.width, true, 80);
	}

	public override function onCreate(event:ScriptEvent):Void
	{
		FlxTween.tween(pinkBack, {x: 0}, 0.6, {ease: FlxEase.quartOut});
		add(pinkBack);

		FlxSpriteUtil.alphaMaskFlxSprite(orangeBackShit, pinkBack, orangeBackShit);
		orangeBackShit.visible = false;
		alsoOrangeLOL.visible = false;

		confirmTextGlow.blend = 0;
		confirmTextGlow.visible = false;

		confirmGlow.blend = 0;

		confirmGlow.visible = false;
		confirmGlow2.visible = false;

		add(confirmGlow2);
		add(confirmGlow);

		add(confirmTextGlow);

		add(backingTextYeah);

		cardGlow.blend = 0;
		cardGlow.visible = false;

		funnyScroll.visible = false;
		funnyScroll2.visible = false;
		funnyScroll3.visible = false;

		funnyScroll.funnyColor = 0xFFFFFFFF;
		funnyScroll.speed = -5;
		add(funnyScroll);

		funnyScroll2.funnyColor = funnyScroll.funnyColor;
		funnyScroll2.speed = -funnyScroll.speed;
		add(funnyScroll2);

		funnyScroll3.funnyColor = funnyScroll.funnyColor;
		funnyScroll3.speed = funnyScroll.speed;
		add(funnyScroll3);

		glowDark = new FlxSprite((FreeplayState.CUTOUT_WIDTH * FreeplayState.DJ_POS_MULTI) + -300, 330).loadGraphic(Paths.image('freeplay/beatglow'));
		glowDark.blend = 9;
		add(glowDark);

		glow = new FlxSprite((FreeplayState.CUTOUT_WIDTH * FreeplayState.DJ_POS_MULTI) + -300, 330).loadGraphic(Paths.image('freeplay/beatglow'));
		glow.blend = 0;
		add(glow);

		glowDark.visible = false;
		glow.visible = false;

		add(cardGlow);
	}

	var beatFreq:Int = 1;
	var beatFreqList:Array<Int> = [1, 2, 4, 8];

	public override function beatHit():Void
	{
		// increases the amount of beats that need to go by to pulse the glow because itd flash like craazy at high bpms.....
		beatFreq = beatFreqList[Math.floor(Conductor.instance.bpm / 140)];

		if (Conductor.instance.currentBeat % beatFreq != 0)
			return;
		FlxTween.cancelTweensOf(glow);
		FlxTween.cancelTweensOf(glowDark);

		glow.alpha = 0.8;
		FlxTween.tween(glow, {alpha: 0}, 16 / 24, {ease: FlxEase.quartOut});
		glowDark.alpha = 0;
		FlxTween.tween(glowDark, {alpha: 0.6}, 18 / 24, {ease: FlxEase.quartOut});
	}

	public override function introDone():Void
	{
		super.introDone();
		funnyScroll.visible = true;
		funnyScroll2.visible = true;
		funnyScroll3.visible = true;
		// grpTxtScrolls.visible = true;
		glowDark.visible = true;
		glow.visible = true;
	}

	public override function confirm():Void
	{
		super.confirm();
		// FlxTween.color(bgDad, 0.33, 0xFFFFFFFF, 0xFF555555, {ease: FlxEase.quadOut});

		funnyScroll.visible = false;
		funnyScroll2.visible = false;
		funnyScroll3.visible = false;
		glowDark.visible = false;
		glow.visible = false;
	}

	public override function disappear():Void
	{
		super.disappear();

		funnyScroll.visible = false;
		funnyScroll2.visible = false;
		funnyScroll3.visible = false;
		glowDark.visible = false;
		glow.visible = false;
	}
}
