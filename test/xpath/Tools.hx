package xpath;

import haxe.ds.Either;
import xpath.tokenizer.ExpectedException;
import xpath.tokenizer.TokenizerOutput;

class Tools {
	static public function tokens(tokenizeResult:Either<TokenizerOutput, Array<{tokenName:String, position:Int}>>) {
		switch(tokenizeResult) {
			case Left(result):
				return result;
			case Right(pendingTokens):
				throw new ExpectedException(pendingTokens);
		}
	}
}