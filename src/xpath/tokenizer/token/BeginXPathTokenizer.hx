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


package xpath.tokenizer.token;
import xpath.tokenizer.token.TokenTokenizer;
import xpath.tokenizer.Tokenizer;
import xpath.tokenizer.TokenizerInput;
import xpath.tokenizer.Token;
import xpath.tokenizer.ExpectedException;


/** [Tokenizer] which tokenizes according to the [BeginXPath]
 * rule. */
class BeginXPathTokenizer extends TokenTokenizer {
	
	static var instance :BeginXPathTokenizer;
	
	
	/** Gets the instance of [BeginXPathTokenizer]. */
	public static function getInstance () {
		if (instance == null) instance = new BeginXPathTokenizer();
		return instance;
	}
	
	function new () {
	}
	
	override public function tokenize (input:TokenizerInput) {
		if (input.position == 0) {
			var result = [ cast(new BeginXPathToken(), Token) ];
			var characterLength = countWhitespace(input.query, 0);
			return input.getOutput(result, characterLength);
		} else {
			throw new ExpectedException([{
				tokenName: "BeginXPath",
				position: input.position
			}]);
		}
	}
	
}
