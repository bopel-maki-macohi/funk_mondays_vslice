import funkin.play.character.MultiAnimateAtlasCharacter;

class MondayGirlCarCharacter extends MondayGirlCharacter
{
	override public function new()
	{
		super('monday-girl-car');
	}

}

class MondayGirlCharacter extends MultiAnimateAtlasCharacter
{
	override public function new(char:String = 'monday-girl')
	{
		char ??= 'monday-girl';

		if (char == 'UNKNOWN')
			char = 'monday-girl';

		super(char);
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
		{
			if (comboCount < 100)
				this.comboNoteCounts.remove(comboCount);

			this.playAnimation('cheer', true, true);
		}
	}
}
