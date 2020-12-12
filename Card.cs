using System.Collections.Generic;

namespace SakuraScript
{
    public class Card
    {
        private string _id;
        private string _name = "";
        private int _flare = -1;
        private CardType _type = CardType.NoType;
        private CardType _subType = CardType.NoType;
        private string _description = "";
        private readonly List<IComponent> _components = new List<IComponent>();

        public Card(string id)
        {
            Id = id;
        }

        public string Id { get => _id; set => _id = value; }
        public string Name { get => _name; set => _name = value; }
        public int Flare { get => _flare; set => _flare = value; }
        public CardType Type { get => _type; set => _type = value; }
        public CardType SubType { get => _subType; set => _subType = value; }
        public string Description { get => _description; set => _description = value; }
        public List<IComponent> Components => _components;

    }
}
