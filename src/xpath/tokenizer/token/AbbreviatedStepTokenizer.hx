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
import xpath.tokenizer.TokenizerInput;
import xpath.tokenizer.Token;
import xpath.tokenizer.ExpectedException;
import haxe.ds.Either;


/** [Tokenizer] which tokenizes according to the [AbbreviatedStep]
 * rule. */
class AbbreviatedStepTokenizer extends TokenTokenizer {
    static var instance:AbbreviatedStepTokenizer;


    /** Gets the instance of [AbbreviatedStepTokenizer]. */
    public static function getInstance() {
        if (instance == null) {
            instance = new AbbreviatedStepTokenizer();
        }

        return instance;
    }

    function new() {
    }

    override public function tokenize(input:TokenizerInput) {
        if (input.query.substr(input.position, 2) == "..") {
            var result = [
                cast(new AxisToken(Parent), Token),
                new TypeTestToken(Node)
            ];
            var characterLength = 2 + countWhitespace(input.query, input.position + 2);
            return Left(input.getOutput(result, characterLength));
        } else if (input.query.charAt(input.position) == ".") {
            var result = [
                cast(new AxisToken(Self), Token),
                new TypeTestToken(Node)
            ];
            var characterLength = 1 + countWhitespace(input.query, input.position + 1);
            return Left(input.getOutput(result, characterLength));
        } else {
            return Right([{ tokenName: "AbbreviatedStep", position: input.position }]);
        }
    }
}
