import funkin.Conductor;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.ui.freeplay.dj.AnimateAtlasFreeplayDJ;
import funkin.ui.freeplay.dj.FreeplayDJState;
import funkin.data.freeplay.player.PlayerRegistry;
import funkin.util.MathUtil;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import funkin.data.song.SongData;
import funkin.data.song.SongTimeChange;

using StringTools;

class MondayBoyfriendFreeplayDJ extends AnimateAtlasFreeplayDJ
{
	var speaker:FunkinSprite;

	var speakerX:Float = 0;
	var speakerY:Float = 0;

	var speakerBack:Bool = false;

	var internalConductor:Conductor;

	public function new(x:Float, y:Float, characterId:String)
	{
		super(x, y, characterId);

		animation.onFrameChange.add((name, number) ->
		{
			onFrameChange(name, number);
		});

		speaker = new FunkinSprite();
		speaker.loadTexture('funk_mondays/freeplay/dj/boy/speaker');
		speaker.y = FlxG.height - speaker.height;

		speakerX = speaker.x;
		speakerY = FlxG.height - speaker.height;

		internalConductor = new Conductor();
		internalConductor.onBeatHit.add(onBeatHit);
	}

	function onBeatHit()
	{
		var beat = internalConductor.currentBeat;

		// trace(beat);

		if (currentState == FreeplayDJState.Idle && animation != null)
			animation?.play(playableCharData?.getAnimationPrefix('idle'));
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
			trace('Finished ${name} : moving to idle');
			currentState = FreeplayDJState.Idle;
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
		if (speaker != null && speaker.visible && this.visible)
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

		if (internalConductor != null && FlxG.sound.music != null && internalConductor.currentTimeChange != null)
			internalConductor.update(FlxG.sound?.music?.time ?? 0.0);
	}

	public override function destroy():Void
	{
		super.destroy();

		// if (internalConductor != null)
		// internalConductor.destroy();
	}

	/**
	 * Called when a capsule is selected.
	 */
	public function onCapsuleSelected(event:CapsuleScriptEvent):Void
	{
		super.onCapsuleSelected(event);

		var song:SongData = null;
		var diff:SongDifficulty = null;
		var timeChanges:Array<SongTimeChange> = [];
		var randomCapsule = event?.capsule?.freeplayData != null;

		if (!randomCapsule)
		{
			song = event.capsule.freeplayData?.data;
			diff = song?.getDifficulty(event.difficultyId, event.variationId);

			if (diff != null)
				timeChanges = diff?.timeChanges;

			_data.bgAsset = 'funk_mondays/freeplay/dj/boy/freeplayBG-${song.id}';
		}
		else
		{
			timeChanges = [new SongTimeChange(0, 145)];

			// multiple random ones?
			_data.bgAsset = 'funk_mondays/freeplay/dj/boy/freeplayBG-random';
		}

		if (internalConductor != null)
		{
			// trace(diff);
			// trace(timeChanges);

			if (timeChanges != null && timeChanges.length > 0)
				internalConductor.mapTimeChanges(timeChanges);
		}

		if (currentState == FreeplayDJState.Idle)
		{
			currentState = FreeplayDJState.Cartoon;
			animation?.play(playableCharData?.getAnimationPrefix('switchSong'), true);
		}
	}

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
		super.onFreeplayIntroDone(event);
		speakerY = FlxG.height - speaker.height;
	}

	/**
	 * Called when the Freeplay outro begins.
	 */
	public function onFreeplayOutro(event:FreeplayScriptEvent):Void
	{
		super.onFreeplayOutro(event);
		FlxTween.num(speakerX, -this.width * 1.8, 0.5, {ease: FlxEase.expoIn}, speakerXTween);
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
	public function onFreeplayClose(event:FreeplayScriptEvent):Void
	{
		super.onFreeplayClose(event);
	}
}
