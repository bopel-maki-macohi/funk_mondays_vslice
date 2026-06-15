import scripts.mondays.util.MondaySong;

class MrDearestSong extends MondaySong
{
	override public function new()
	{
		super('mrdearest');
	}

	override function reinitCamOffsets()
	{
		super.reinitCamOffsets();

		startCamOffsets = [-50, -160];
		startZoomOffset = -0.2;
	}
}
