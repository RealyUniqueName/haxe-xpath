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


package xpath.tokenizer;
import haxe.unit.TestCase;
import xpath.tokenizer.TokenizerException;


class TokenizerExceptionTest extends TestCase {
    function testToString():Void {
        var tokenizerException = new TokenizerException();
        assertEquals("TokenizerException", tokenizerException.toString());

        tokenizerException = new TokenizerException("");
        assertEquals("TokenizerException", tokenizerException.toString());

        tokenizerException = new TokenizerException(42);
        assertEquals("character 42: TokenizerException", tokenizerException.toString());

        tokenizerException = new TokenizerException(42, "");
        assertEquals("character 42: TokenizerException", tokenizerException.toString());

        tokenizerException = new TokenizerException("bananas");
        assertEquals("bananas", tokenizerException.toString());

        tokenizerException = new TokenizerException(42, "bananas");
        assertEquals("character 42: bananas", tokenizerException.toString());
    }
}
