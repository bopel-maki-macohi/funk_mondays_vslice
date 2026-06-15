import scripts.mondays.util.MondaySong;

class SpookyDownSouthSong extends MondaySong
{
	override public function new()
	{
		super('spookydownsouth');
	}

	override function reinitCamOffsets()
	{
		super.reinitCamOffsets();

		startCamOffsets = [-50, -160];
		startZoomOffset = -0.2;
	}
}
