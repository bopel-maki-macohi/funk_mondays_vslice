package mods.funk_mondays.scripts.mondays.songs;

import mondays.MondayUI;
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
}
