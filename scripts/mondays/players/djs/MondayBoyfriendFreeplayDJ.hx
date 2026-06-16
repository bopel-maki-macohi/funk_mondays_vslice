import funkin.Conductor;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.ui.freeplay.dj.AnimateAtlasFreeplayDJ;
import funkin.ui.freeplay.dj.FreeplayDJState;
import funkin.data.freeplay.player.PlayerRegistry;
import funkin.util.MathUtil;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

using StringTools;

class MondayBoyfriendFreeplayDJ extends AnimateAtlasFreeplayDJ
{
	var speaker:FunkinSprite;

	var speakerX:Float = 0;
	var speakerY:Float = 0;

	var speakerBack:Bool = false;

	public function new(x:Float, y:Float, characterId:String)
	{
		super(x, y, characterId);

		animation.onFrameChange.add((name, number) ->
		{
			onFrameChange(name, number);
		});

		speaker = new FunkinSprite();
		speaker.loadTexture('funk_mondays/freeplay/dj/speaker-boy');
		speaker.y = FlxG.height - speaker.height;

		speakerX = speaker.x;
		speakerY = FlxG.height - speaker.height;

		Conductor.instance.onBeatHit.add(onBeatHit);
	}

	function onBeatHit()
	{
		var beat = Conductor.instance.currentBeat;

		if (currentState == FreeplayDJState.Idle)
			animation.play(playableCharData?.getAnimationPrefix('idle'));
	}

	function onFrameChange(anim:String, frame:Int)
	{
		// trace(anim + ' : $frame');

		if (anim == playableCharData?.getAnimationPrefix('intro'))
		{
			speakerBack = (frame > 7 && frame < 13);
		}
	}

	override function onFinishAnim(name:String):Void
	{
		if (name == playableCharData?.getAnimationPrefix('intro'))
		{
			currentState = (PlayerRegistry.instance.hasNewCharacter()) ? FreeplayDJState.Idle : FreeplayDJState.Idle;
			onIntroDone.dispatch();
			animation.play(playableCharData?.getAnimationPrefix('idle'));
		}
		else if (name == playableCharData?.getAnimationPrefix('idle'))
		{
			// if (timeIdling >= IDLE_EGG_PERIOD && !seenIdleEasterEgg)
			// 	currentState = FreeplayDJState.IdleEasterEgg;
			// else if (timeIdling >= IDLE_CARTOON_PERIOD)
			// 	currentState = FreeplayDJState.Cartoon;
		}
		else if (name == playableCharData?.getAnimationPrefix('confirm'))
		{
			// trace('Finished confirm');
		}
		else if (name == playableCharData?.getAnimationPrefix('fistPump'))
		{
			// trace('Finished fist pump');
			currentState = FreeplayDJState.Idle;
		}
		else if (name == playableCharData?.getAnimationPrefix('idleEasterEgg'))
		{
			// trace('Finished spook');
			currentState = FreeplayDJState.Idle;
		}
		else if (name == playableCharData?.getAnimationPrefix('loss'))
		{
			// trace('Finished loss reaction');
			currentState = FreeplayDJState.Idle;
		}
		else if (name == playableCharData?.getAnimationPrefix('newUnlock'))
		{
			// Animation should loop.
		}
		else if (name == playableCharData?.getAnimationPrefix('charSelect'))
		{
			onCharSelectComplete();
		}
		else
		{
			trace('Finished ${name}');
		}
	}

	public override function draw():Void
	{
		if (speakerBack)
			drawSpeaker();

		super.draw();

		if (!speakerBack)
			drawSpeaker();
	}

	function drawSpeaker()
	{
		if (speaker != null && speaker.visible)
		{
			speaker.cameras = _cameras;
			speaker.draw();
		}
	}

	public function onUpdate(event:UpdateScriptEvent):Void
	{
		super.onUpdate(event);

		speaker.x = MathUtil.smoothLerpPrecision(speaker.x, speakerX, event.elapsed, 0.4);
		speaker.y = MathUtil.smoothLerpPrecision(speaker.y, speakerY, event.elapsed, 0.4);
	}

	/**
	 * Called when a capsule is selected.
	 */
	public function onCapsuleSelected(event:CapsuleScriptEvent):Void {}

	/**
	 * Called when the current difficulty is changed.
	 */
	public function onDifficultySwitch(event:CapsuleScriptEvent):Void {}

	/**
	 * Called when a song is selected.
	 */
	public function onSongSelected(event:CapsuleScriptEvent):Void {}

	/**
	 * Called when the intro for Freeplay finishes.
	 */
	public function onFreeplayIntroDone(event:FreeplayScriptEvent):Void
	{
		speakerY = FlxG.height - speaker.height;
	}

	/**
	 * Called when the Freeplay outro begins.
	 */
	public function onFreeplayOutro(event:FreeplayScriptEvent):Void
	{
		FlxTween.num(speakerX, -this.width * 1.6, 0.5, {ease: FlxEase.expoIn}, speakerXTween);
	}

	override function toCharSelect()
	{
		super.toCharSelect();

		FlxTween.num(speakerY, -178 + speakerY, 0.8, {ease: FlxEase.backIn, startDelay: playableCharData?.getCharSelectTransitionDelay() ?? 0.25},
			speakerYTween);
	}

	function speakerXTween(num:Float)
	{
		speakerX = num;
	}

	function speakerYTween(num:Float)
	{
		speakerY = num;
	}

	function speakerPosTweenDone(tween:FlxTween)
	{
		speakerY = FlxG.height - speaker.height;
	}

	/**
	 * Called when Freeplay is closed.
	 */
	public function onFreeplayClose(event:FreeplayScriptEvent):Void {}
}
