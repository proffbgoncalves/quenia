package br.edu.compiladores.quenya;

import java.text.Normalizer;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CodePointCharStream;
import org.antlr.v4.runtime.Token;

public class CompiladorQuenya {

    public static void analisarTokens(String nomeTeste, String codigoFonte) {
        System.out.println("\n==================================================");
        System.out.println("TESTE: " + nomeTeste);
        System.out.println("==================================================");

        // Seção 5: Garante a forma Unicode NFC antes da análise léxica
        String codigoNFC = Normalizer.normalize(codigoFonte, Normalizer.Form.NFC);

        CodePointCharStream input = CharStreams.fromString(codigoNFC);
        QuenyaLexer lexer = new QuenyaLexer(input);

        Token token = lexer.nextToken();
        boolean temErro = false;

        while (token.getType() != Token.EOF) {
            String nomeToken = QuenyaLexer.VOCABULARY.getSymbolicName(token.getType());
            int linha = token.getLine();
            int coluna = token.getCharPositionInLine() + 1;

            if (nomeToken != null && nomeToken.startsWith("ERR_")) {
                temErro = true;
                System.out.printf("[ERRO LÉXICO] Linha %d, Coluna %d (%s): '%s'%n",
                        linha, coluna, nomeToken, token.getText());
            } else {
                System.out.printf("Linha %2d | Col %2d | Token: %-18s | Texto: '%s'%n",
                        linha, coluna, nomeToken, token.getText());
            }
            token = lexer.nextToken();
        }

        if (!temErro) {
            System.out.println("-> Resultado: Análise léxica concluída sem erros!");
        }
    }

    public static void main(String[] args) {
        // Exemplo válido baseado na Seção 25 do PDF
        String programaValido =
            "tamna {\n" +
            "    tengwë_et led = tengwë(13): undu;\n" +
            "}\n" +
            "tanca toldo limite = 3;\n" +
            "yesta {\n" +
            "    téma 9600;\n" +
            "}\n" +
            "carda {\n" +
            "    lutu temperatura = 21.5;\n" +
            "    toldo mascara = 0b00001111;\n" +
            "    á quet_metta \"Ola\\n\";\n" +
            "}";

        analisarTokens("Programa Quenya Válido", programaValido);

        // Exemplo com erros léxicos da Seção 26.1 do PDF
        String programaComErros =
            "toldo a = 007;\n" +
            "toldo b = 0b102;\n" +
            "toldo 2contador = 1;\n" +
            "lutu c = 1.2.3;\n" +
            "toldo d = @;";

        analisarTokens("Casos de Erro Léxico (Seção 26.1)", programaComErros);
    }
}