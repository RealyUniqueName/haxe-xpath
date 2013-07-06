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


package xpath.tokenizer.container;
import xpath.tokenizer.Tokenizer;
import xpath.tokenizer.TokenizerInput;
import xpath.tokenizer.util.Sequence;
import xpath.tokenizer.util.Optional;
import xpath.tokenizer.container.FunctionArgumentsTokenizer;
import xpath.tokenizer.token.BeginFunctionCallTokenizer;
import xpath.tokenizer.token.EndFunctionCallTokenizer;


/** [Tokenizer] which tokenizes according to the [FunctionCall]
 * rule. */
class FunctionCallTokenizer implements Tokenizer {
	
	static var instance :FunctionCallTokenizer;
	
	var tokenizer :Tokenizer;
	
	
	/** Gets the instance of [FunctionCallTokenizer]. */
	public static function getInstance () {
		if (instance == null) {
			instance = new FunctionCallTokenizer();
			instance.init();
		}
		return instance;
	}
	
	function new () {
	}
	
	function init () {
		tokenizer = new Sequence([
			cast(BeginFunctionCallTokenizer.getInstance(), Tokenizer),
			new Optional([
				cast(FunctionArgumentsTokenizer.getInstance(), Tokenizer)
			]), EndFunctionCallTokenizer.getInstance()
		]);
	}
	
	/** Tokenizes [input], which represents a partially tokenized
	 * XPath query string. Returns the resulting [TokenizerOutput].
	 *
	 * Throws [TokenizerException] if the [input] cannot be
	 * tokenized by this [Tokenizer]. */
	public function tokenize (input:TokenizerInput) {
		return tokenizer.tokenize(input);
	}
	
}
