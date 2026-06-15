import funkin.play.song.Song;
import funkin.play.PlayState;

class MondaySong extends Song
{
	var startCamOffsets:Array<Float> = [];
	var startZoomOffset:Float = 0.0;

	public override function onCountdownStart(event:CountdownScriptEvent):Void
	{
		super.onCountdownStart(event);
		MondayUI.uiInit(startCamOffsets, startZoomOffset);
	}

	override public function onUpdate(elapsed)
	{
		super.onUpdate(elapsed);
		MondayUI.scoreUpdate();
	}

	public override function isSongNew(currentDifficulty:String, currentVariation:String):Bool
	{
		return !Save.instance.hasBeatenSong(this.id, null, this.variation);
	}
}
