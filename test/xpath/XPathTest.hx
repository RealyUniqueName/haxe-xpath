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


package xpath;
import xpath.xml.XPathXml;
import xpath.value.XPathNodeSet;
import xpath.value.XPathString;
import xpath.context.Context;
import xpath.value.XPathValue;
import xpath.context.DynamicEnvironment;
import haxe.unit.TestCase;
import xpath.tokenizer.TokenizerException;
import xpath.value.XPathBoolean;
import xpath.value.XPathNumber;
import xpath.xml.XPathHxXml;


class XPathTest extends TestCase {
    /* <a>
     *     <b/>
     *     <c name="foo"/>
     *     <d name="bar">
     *         <e name="foo"/>
     *     </d>
     * </a> */
    var xml:Xml;
    var a:Xml;
    var b:Xml;
    var c:Xml;
    var d:Xml;
    var e:Xml;


    public function new() {
        super();

        xml = Xml.createDocument();
        a = Xml.createElement("a");
        b = Xml.createElement("b");
        c = Xml.createElement("c");
        d = Xml.createElement("d");
        e = Xml.createElement("e");

        c.set("name", "foo");
        d.set("name", "bar");
        e.set("name", "foo");

        xml.addChild(a);
        a.addChild(b);
        a.addChild(c);
        a.addChild(d);
        d.addChild(e);
    }

    function testComplexContains() {
        var xpathXml = XPathHxXml.wrapNode(xml);
        var xpathQry = new XPath("//*[contains(@name, 'bar')]");
        var nodes = Lambda.array(xpathQry.selectNodes(xpathXml));
        assertEquals(1, nodes.length);
        assertEquals(e, cast(nodes[0], XPathHxXml).getWrappedXml());
    }
}
