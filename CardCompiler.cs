using System;
using System.Collections.Generic;

namespace SakuraScript
{
    public class CardCompiler
    {
        private readonly List<Card> _cards;
        private Card _lastCard;

        public CardCompiler()
        {
            _cards = new List<Card>();
            LastCard = null;
        }

        internal Card LastCard { get => _lastCard; set => _lastCard = value; }
        public int ParseInteger(string i)
        {
            if (i.ToLower() == "inf")
            {
                return int.MaxValue;
            }
            return int.Parse(i);
        }

        public string ParseString(string s)
        {
            return s[1..^1].Replace("\\\"", "\"");
        }

        public CardType ParseCardType(string ct)
        {
            return ct.ToLower() switch
            {
                "atk" => CardType.Attack,
                "act" => CardType.Action,
                "enh" => CardType.Enhancement,
                "rea" => CardType.Reaction,
                "thr" => CardType.Throughout,
                _ => CardType.NoType,
            };
        }

        public void AddCard(string id)
        {
            LastCard = new Card(id);
            _cards.Add(LastCard);
        }

        public void PrintCardNames()
        {
            foreach(Card card in _cards)
            {
                Console.WriteLine(card.Name);
            }
        }
    }
}
