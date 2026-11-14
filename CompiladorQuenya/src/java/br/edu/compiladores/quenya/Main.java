package br.edu.compiladores.quenya;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.Normalizer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;

public class Main {

    public static void main(String[] args) throws IOException {
        InputStream stream = Main.class.getResourceAsStream("/avaliacao_aluno.qya");
        if (stream == null) {
            throw new IllegalStateException("Arquivo .qya nao encontrado.");
        }

        String texto = new String(stream.readAllBytes(), StandardCharsets.UTF_8);
        String nfc = Normalizer.normalize(texto, Normalizer.Form.NFC);

        CharStream input = CharStreams.fromString(nfc);
        QuenyaLexer lexer = new QuenyaLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        tokens.fill();
        for (Token token : tokens.getTokens()) {
            String name = QuenyaLexer.VOCABULARY.getSymbolicName(token.getType());
            System.out.printf("%-18s %s%n", name, token.getText());
        }

        QuenyaParser parser = new QuenyaParser(tokens);
        var arvore = parser.programa();
        System.out.println(arvore.toStringTree(parser));

        var visitor = new InspecaoVisitor(System.out);
        visitor.visit(arvore);
    }
}
