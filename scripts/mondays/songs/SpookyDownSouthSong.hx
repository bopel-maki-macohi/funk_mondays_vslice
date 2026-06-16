import scripts.mondays.util.MondaySong;

import funkin.play.PlayState;

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

	override function onCountdownStart(event:Dynamic)
	{
		super.onCountdownStart(event);

		var stage = PlayState.instance.currentStage;

		if (stage != null)
			stage.getDad()
				.color = stage.getGirlfriend()
					.color = stage.getBoyfriend()
						.color = 0x888888;
	}
}
