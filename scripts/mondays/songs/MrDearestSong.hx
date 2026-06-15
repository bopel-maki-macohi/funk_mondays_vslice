package mods.funk_mondays.scripts.mondays.songs;

import mondays.MondaySongManager;
import funkin.play.song.Song;

class MrDearestSong extends Song
{
	public function new()
	{
		super('mrdearest');
	}

	public override function onCountdownStart(event:CountdownScriptEvent):Void
	{
		super.onCountdownStart(event);
		MondaySongManager.middleScroll();
	}
}
