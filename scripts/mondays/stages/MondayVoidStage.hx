package scripts.mondays.stages;

import flixel.util.FlxColor;
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

	function makeBaseStageProp(img:String)
	{
		var prop:StageProp = new StageProp();
		prop.loadTexture(getPath(img));
		prop.active = false;
		return prop;
	}

	var void:StageProp;

	function buildStage()
	{
		super.buildStage();

		void = new StageProp();
		void.makeSolidColor(Std.int(FlxG.width * 1.1), Std.int(FlxG.height * 1.1), FlxColor.fromString('0xFFFFFF'));
		void.scale.set(FlxG.width * 1.1, FlxG.height * 1.1);
		void.antialiasing = false;
		void.active = false;
		addProp(void, 'stage');

		var game = PlayState.instance;

		trace(game.currentSong.songName);

		switch (game.currentSong.songName)
		{
			case 'Spooky Down South':
				buildSpookyPlace();
			default:
				// case 'MrDearest':
				buildMondayStage();
		}

		refresh();
	}

	function buildSpookyPlace()
	{
		this._data.cameraZoom = 0.85;

		var floor:StageProp = makeBaseStageProp('spookyPlace/floor');
		floor.scale.set(2, 2);
		floor.setPosition(0, 825);
		addProp(floor, 'floor');

		var window:StageProp = makeBaseStageProp('spookyPlace/window');
		// window.scale.set(1.5, 1.5);
		window.setPosition(0, 50);
		addProp(window, 'window');

		var staircase:StageProp = makeBaseStageProp('spookyPlace/staircase');
		staircase.scale.set(2, 2);
		staircase.setPosition(1180, 500);
		staircase.alpha = 0.5;
		staircase.zIndex = 400;
		staircase.scrollFactor.set(0.5, 0.5);
		addProp(staircase, 'staircase');

		void.color = floor.color = window.color = staircase.color = 0x888888;
	}

	function buildMondayStage()
	{
		this._data.cameraZoom = 0.8;

		var stage:StageProp = makeBaseStageProp('mondayStage/stage');
		stage.setPosition(60, 725);
		addProp(stage, 'stage');

		var curtains:StageProp = makeBaseStageProp('mondayStage/curtains');
		curtains.scale.set(2, 2);
		curtains.scrollFactor.set(0.5, 0.5);
		curtains.zIndex = 400;
		addProp(curtains, 'curtains');
	}
}
