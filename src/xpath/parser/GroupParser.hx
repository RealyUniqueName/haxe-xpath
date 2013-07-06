/* Haxe XPath by Daniel J. Cassidy <mail@danielcassidy.me.uk>
 * Dedicated to the Public Domain
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS 
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */


package xpath.parser;
import xpath.tokenizer.Token;


class GroupParser implements Parser {
	
	static var instance :GroupParser;
	
	
	public static function getInstance () {
		if (instance == null) instance = new GroupParser();
		return instance;
	}
	
	function new () {
	}
	
	public function parse (input:ParserInput) {
		if (!input.hasNext()) return null;
		var token = input.next();
		if (!Std.is(token, BeginGroupToken)) return null;
		
		var output = ExpressionParser.getInstance().parse(input.descend());
		if (output.result == null) throw new ParseError(
			"Invalid token stream"
		);
		input = output.getNextInput();
		
		if (!input.hasNext()) throw new ParseError(
			"Invalid token stream"
		);
		if (!Std.is(input.next(), EndGroupToken)) throw new ParseError(
			"Invalid token stream"
		);
		
		var result = output.result;
		return input.getOutput(input.count, result);
	}
	
}
