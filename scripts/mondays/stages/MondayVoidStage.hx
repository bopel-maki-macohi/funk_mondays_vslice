package scripts.mondays.stages;

import funkin.Paths;
import funkin.graphics.FunkinSprite;
import funkin.play.PlayState;
import funkin.play.stage.Stage;
import funkin.play.stage.StageProp;

class MondayVoidStage extends Stage
{
	override public function new()
	{
		super('monday-void');
	}

	function getPath(path:String):String
	{
		return 'funk_mondays/stages/$path';
	}

	function buildStage()
	{
		super.buildStage();

		var game = PlayState.instance;

		trace(game.currentSong.songName);

		switch (game.currentSong.songName)
		{
			default:
				// case 'MrDearest':
				buildMondayStage();
		}

		refresh();
	}

	function buildMondayStage()
	{
		this._data.cameraZoom = 0.8;

		var stage:StageProp = new StageProp();
		stage.loadTexture(getPath('mondayStage/stage'));
		stage.active = false;
		stage.setPosition(60, 725);
		addProp(stage, 'stage');

		var curtains:StageProp = new StageProp();
		curtains.loadTexture(getPath('mondayStage/curtains'));
		curtains.active = false;
		curtains.scale.set(2, 2);
		curtains.scrollFactor.set(0.5, 0.5);
		curtains.zIndex = 400;
		addProp(curtains, 'curtains');
	}
}
