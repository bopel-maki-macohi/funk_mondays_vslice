import scripts.mondays.util.MondaySong;
import funkin.play.PlayState;

class AssasinationSong extends MondaySong
{
	override public function new()
	{
		super('assasination');
	}

	override function reinitCamOffsets()
	{
		super.reinitCamOffsets();

		startCamOffsets = [-50, -160];
		startZoomOffset = -0.2;
	}
}
