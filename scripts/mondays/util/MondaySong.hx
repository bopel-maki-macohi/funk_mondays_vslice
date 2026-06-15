package scripts.mondays.util;

import funkin.save.Save;
import funkin.play.song.Song;
import funkin.play.PlayState;

class MondaySong extends Song
{
	var startCamOffsets:Array<Float> = [];
	var startZoomOffset:Float = 0.0;

	var initCamOffsets:Bool = false;

	override public function new(song:String)
	{
		super(song);

		reinitCamOffsets();
	}

	function reinitCamOffsets()
	{
		initCamOffsets = true;

		startCamOffsets = [0, 0];
		startZoomOffset = 0;
	}

	public override function onSongRetry(event:SongRetryEvent):Void
	{
		super.onSongRetry(event);

		initCamOffsets = false;
		MondayUI.camInit(startCamOffsets, startZoomOffset);
	}

	public override function onCountdownStart(event:CountdownScriptEvent):Void
	{
		super.onCountdownStart(event);

		initCamOffsets = false;
		MondayUI.uiInit();
	}

	override public function onUpdate(elapsed)
	{
		super.onUpdate(elapsed);

		if (!initCamOffsets)
		{
			reinitCamOffsets();
			MondayUI.camInit(startCamOffsets, startZoomOffset);
		}

		MondayUI.scoreUpdate();
	}

	public override function isSongNew(currentDifficulty:String, currentVariation:String):Bool
	{
		return !Save.instance.hasBeatenSong(this.id, null, this.variation);
	}
}
