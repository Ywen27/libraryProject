package com.yx.codeutil;

import java.io.IOException;
import java.io.OutputStream;
public interface IVerifyCodeGen {
    /**
     * Générer un code de vérification et le renvoyez, écrire l'image dans os
     *
     * @param width
     * @param height
     * @param os
     * @return
     * @throws IOException
     */
    String generate(int width, int height, OutputStream os) throws IOException;

    /**
     * Générer l'objet de code de vérification
     *
     * @param width
     * @param height
     * @return
     * @throws IOException
     */
    VerifyCode generate(int width, int height) throws IOException;
}
