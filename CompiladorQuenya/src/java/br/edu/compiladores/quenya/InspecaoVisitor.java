package br.edu.compiladores.quenya;

import java.io.PrintStream;

public class InspecaoVisitor extends QuenyaParserBaseVisitor<Void> {

    private final PrintStream saida;

    public InspecaoVisitor(PrintStream saida) {
        this.saida = saida;
    }

    @Override
    public Void visitPrograma(QuenyaParser.ProgramaContext ctx) {
        saida.println("programa: " + ctx.declaracaoGlobal().size() + " global(is), "
                + ctx.declaracaoFuncao().size() + " funcao(oes)");
        return visitChildren(ctx);
    }

    @Override
    public Void visitDeclaracaoGlobal(QuenyaParser.DeclaracaoGlobalContext ctx) {
        saida.println("global: " + ctx.ID().getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitDeclaracaoLocal(QuenyaParser.DeclaracaoLocalContext ctx) {
        saida.println("local: " + ctx.ID().getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitAtribuicao(QuenyaParser.AtribuicaoContext ctx) {
        saida.println("atribuicao: " + ctx.ID().getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitExpressaoPrimaria(QuenyaParser.ExpressaoPrimariaContext ctx) {
        saida.println("primario: " + ctx.getText());
        return visitChildren(ctx);
    }
}
