using System;
using System.IO;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;

namespace SakuraScript
{
    public class Program
    {
        public static void Main()
        {
            string path = "Scripts/yurina.sa";
            SakuraScriptLexer lexer;
            using (FileStream fs = File.Open(path, FileMode.Open))
            {
                AntlrInputStream antlerStream = new AntlrInputStream(fs);
                lexer = new SakuraScriptLexer(antlerStream);
            }
            CommonTokenStream tokenStream = new CommonTokenStream(lexer);
            SakuraScriptParser parser = new SakuraScriptParser(tokenStream);
            parser.AddErrorListener(new ErrorListener());

            Console.WriteLine("Parsing file");
            IParseTree parseTree = parser.cards();
            Console.WriteLine("File parsing ended");
            
            Console.Write("Print parsing tree(Y/n): ");
            string input = Console.ReadLine().Trim();
            if (input == "" || input.ToLower() == "y")
            {
                PrintTree(parseTree);
            }

            Console.WriteLine("Press ENTER to exit");
            Console.ReadLine();
        }

        public static void PrintTree(IParseTree tree)
        {
            ParseTreeWalker walker = new ParseTreeWalker();
            walker.Walk(new Listener(), tree);
        }
    }
    class ErrorListener : BaseErrorListener
    {
        public override void SyntaxError(IRecognizer recognizer, IToken offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
        {
            Console.WriteLine("Syntax error: line {0}:{1} - {2}", line, charPositionInLine, msg);
        }
    }

    class Listener: SakuraScriptParserBaseListener
    {
        public override void EnterEveryRule([NotNull] ParserRuleContext context)
        {
            string tabs = new string(' ', context.Depth());
            string rule = SakuraScriptParser.ruleNames[context.RuleIndex];
            Console.WriteLine(tabs + rule + ':' + context.GetText());
        }
    }
}
