package com.yx.codeutil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

public class SimpleCharVerifyCodeGenImpl implements IVerifyCodeGen{

    private static final Logger logger = LoggerFactory.getLogger(SimpleCharVerifyCodeGenImpl.class);

    private static final String[] FONT_TYPES = {"Arial", "Courier", "Georgia", "Times New Roman", "Verdana"};

    private static final int VALICATE_CODE_LENGTH = 4;

    /**
     * Définir la couleur et la taille de background, les lignes d'interférence
     *
     * @param graphics
     * @param width
     * @param height
     */
    private static void fillBackground(Graphics graphics, int width, int height) {
        // Remplir background
        graphics.setColor(Color.WHITE);
        // Définir les coordonnées du rectangle x y sur 0
        graphics.fillRect(0, 0, width, height);

        // Ajouter des lignes d'interférence
        for (int i = 0; i < 8; i++) {
            // Définir les paramètres de l'algorithme de couleur aléatoire
            graphics.setColor(RandomUtils.randomColor(40, 150));
            Random random = new Random();
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            graphics.drawLine(x, y, x1, y1);
        }
    }

    /**
     * Générer des caractères aléatoires
     *
     * @param width
     * @param height
     * @param os
     * @return
     * @throws IOException
     */
    @Override
    public String generate(int width, int height, OutputStream os) throws IOException {
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics graphics = image.getGraphics();
        fillBackground(graphics, width, height);
        String randomStr = RandomUtils.randomString(VALICATE_CODE_LENGTH);
        createCharacter(graphics, randomStr);
        graphics.dispose();
        // Définir le format JPEG
        ImageIO.write(image, "JPEG", os);
        return randomStr;
    }

    /**
     * Générer le code de vérification
     *
     * @param width
     * @param height
     * @return
     */
    @Override
    public VerifyCode generate(int width, int height) {
        VerifyCode verifyCode = null;
        try (
                // Placer l'initialisation de Stream ici pour n'avoir pas besoin de fermer manuellement le Stream.
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ) {
            String code = generate(width, height, baos);
            verifyCode = new VerifyCode();
            verifyCode.setCode(code);
            verifyCode.setImgBytes(baos.toByteArray());
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
            verifyCode = null;
        }
        return verifyCode;
    }

    /**
     * Définir la couleur et la police des caractères
     *
     * @param graph
     * @param randomStr
     */
    private void createCharacter(Graphics graph, String randomStr) {
        char[] charArray = randomStr.toCharArray();
        for (int i = 0; i < charArray.length; i++) {
            //Définir les paramètres de l'algorithme de couleur RGB
            graph.setColor(new Color(50 + RandomUtils.nextInt(100),
                    50 + RandomUtils.nextInt(100), 50 + RandomUtils.nextInt(100)));
            //Définir la taille et la police
            graph.setFont(new Font(FONT_TYPES[RandomUtils.nextInt(FONT_TYPES.length)], Font.PLAIN, 26));
            //Définir les coordonnées x y
            graph.drawString(String.valueOf(charArray[i]), 15 * i + 5, 19 + RandomUtils.nextInt(8));
        }
    }
}

