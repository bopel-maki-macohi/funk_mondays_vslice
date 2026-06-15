package mondays.characters;

import funkin.play.character.MultiAnimateAtlasCharacter;

class MondayGirlCharacter extends MultiAnimateAtlasCharacter
{
	override public function new()
	{
		super('monday-girl');
	}

	override function onCreate(event:ScriptEvent):Void
	{
		super.onCreate(event);

		var depth = 9;

		this.comboNoteCounts = [10];

		while (depth > 0)
		{
			var latestCNC = this.comboNoteCounts[this.comboNoteCounts.length - 1];

			this.comboNoteCounts.push(latestCNC * 2);

			depth--;
		}

		trace('comboNoteCounts: ' + this.comboNoteCounts);
	}

	function playComboAnimation(comboCount:Int)
	{
		if (this.comboNoteCounts.contains(comboCount))
			this.playAnimation('cheer', true, true);
	}
}
