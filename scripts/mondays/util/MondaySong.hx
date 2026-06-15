import funkin.play.song.Song;
import funkin.play.PlayState;

class MondaySong extends Song
{
	public override function onCountdownStart(event:CountdownScriptEvent):Void
	{
		super.onCountdownStart(event);
		MondayUI.uiInit();
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
