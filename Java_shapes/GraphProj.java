import java.awt.Graphics;
import java.awt.Color;
import java.awt.Font;
import java.util.Random;

/**
 * class draws three different methods: first is the assigned shape, second is my art project,
 * third is extra credit
 * 
 * @author      Nathaniel Wieck
 * @version     14 JAN 2019
 */
public class GraphProj {

    public static final int CANVAS_WIDTH = 500;
    public static final int CANVAS_HEIGHT = 500;
    public static final int LINE_INC = CANVAS_WIDTH / 50;

    /**
     * main method: clears console, and calls other three methods
     */
    public static void main(String[] args) {
        Part1();
        Part2();
        ExtraCredit();
    }

    /**
     * method for part 1 of homework: uses drawing panel to draw different shapes
     * in different colors, and a for loop to draw a rotating square like specified
     */
    public static void Part1() {
        DrawingPanel canvas1 = new DrawingPanel(CANVAS_WIDTH, CANVAS_HEIGHT);
        Graphics tools = canvas1.getGraphics();
        canvas1.setBackground(new Color(75, 0, 130));
        tools.setColor(Color.YELLOW);
        for (int i = 1; i < CANVAS_WIDTH; i = i + LINE_INC) {
            int xPoints[] = {0, i, CANVAS_WIDTH, CANVAS_WIDTH - i};
            int yPoints[] = {i, CANVAS_HEIGHT, CANVAS_HEIGHT-i, 0};
            int nPoints = 4;
            tools.drawPolygon(xPoints, yPoints, nPoints);
        }
    }

    /**
     * method for part 2 of homework: computer generated art uses drawing panel to randomly choose
     * then draw different shapes, including strings, in random colors, sizes, and locations
     */
    public static void Part2() {
        int newWidth = CANVAS_WIDTH * 2;
        int newHeight = CANVAS_HEIGHT * 2;
        DrawingPanel canvas2 = new DrawingPanel(newWidth, CANVAS_HEIGHT * 2);
        Graphics tools = canvas2.getGraphics();
        Random rand = new Random();
        canvas2.setBackground(new Color(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)));
        for (int i = 0; i < 15; i++) {
            tools.setColor(new Color(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)));
            int rand_int1 = rand.nextInt(2);
            if (rand_int1 == 0) {
                tools.fillOval(rand.nextInt(newWidth), rand.nextInt(newHeight),
                    rand.nextInt(newWidth / 20), rand.nextInt(newHeight / 10));
            }   else {
                tools.fillRect(rand.nextInt(newWidth), rand.nextInt(newHeight),
                    rand.nextInt(newWidth / 10), rand.nextInt(newHeight / 15));
            }
            int rand_int2 = rand.nextInt(5);
            switch (rand_int2) {
                case 0:     tools.drawLine(rand.nextInt(newWidth), rand.nextInt(newHeight),
                                rand.nextInt(newWidth), rand.nextInt(newHeight));
                            break;
                case 1:     tools.drawOval(rand.nextInt(newWidth), rand.nextInt(newHeight),
                                rand.nextInt(newWidth), rand.nextInt(newHeight));
                            break;
                case 2:     tools.drawRect(rand.nextInt(newWidth), rand.nextInt(newHeight),
                                rand.nextInt(newWidth), rand.nextInt(newHeight));
                            break;
                default:    String[] pron = {"I ", "You ", "He ", "She ", "It ", "We ", "They "};
                            
                            String[] verb = {"analyzed ", "devoured ", "oversaw ", "burnt down ",
                                "critiqued ", "engineered ", "destroyed "};

                            String[] noun = {"factory reset buttons ", "belly buttons ", "sandwiches ",
                                "wizards ", "kimchi ", "muffin tops ", "mental disorders "};

                            String[] comp = {"more than ", "even without ", "less than ",
                                "cheek to cheek with ", "so much more than ", "like ", "a fraction as much as "};

                            String[] person = {"Donald Trump", "Professor Barry", "Nathaniel Wieck",
                                "Presidente Beebeecaca", "Boba Fett", "grandma", "your mom"};

                            String[] end = {".", "!", "...", ", right?", ", so...", " haha lol", " o_0;"};
                            
                            String wisdom = pron[rand.nextInt(7)] + verb[rand.nextInt(7)] + noun[rand.nextInt(7)] +
                                comp[rand.nextInt(7)] + person[rand.nextInt(7)] + end[rand.nextInt(7)];
                            tools.setFont(new Font("SansSerif", Font.PLAIN, rand.nextInt(42)));
                            tools.drawString(wisdom, rand.nextInt(newWidth / 3), rand.nextInt(newHeight));
                            break;
            }    
            tools.setColor(Color.WHITE);
            tools.fillRect(0, 0, 190, 20);
            tools.setColor(Color.BLACK);
            tools.setFont(new Font("SansSerif", Font.PLAIN, 18));
            tools.drawString("A r t i f i c i a l   A R T", 12, 15);
            tools.setColor(Color.BLACK);
            tools.fillRect(0, 20, 190, 28);
            tools.setColor(Color.WHITE);
            tools.drawString("( randomly generated )", 5, 40);
            tools.setColor(Color.BLACK);
            tools.fillRect (newWidth - 300, newHeight - 70, newWidth, newHeight);
            tools.setColor(new Color(127,255,0));
            for(int iter = 0; iter < 2; iter++) {
                int rand_response = rand.nextInt(3);
                String[] response = {"CELLS;", "INTERLINKED;", "WITHIN CELLS INTERLINKED;"};
                String baseline = response[rand.nextInt(3)];
                if (iter == 0) {
                    tools.drawString(baseline, newWidth - 290, newHeight - 56);
                    tools.drawString(baseline, newWidth - 250, newHeight - 39);
                }   else {
                    tools.drawString(baseline, newWidth - 290, newHeight - 22);
                    tools.drawString(baseline, newWidth - 250, newHeight - 5);
                }
            }
        }
    }

    /**
     * method for extra credit: uses drawing panel and trigonometry to draw equilateral triangles in a circular pattern.
     */
    public static void ExtraCredit() {
        double radius = Math.min(CANVAS_WIDTH/2, CANVAS_HEIGHT/2);
        Random rand = new Random();
        DrawingPanel canvas1 = new DrawingPanel(CANVAS_WIDTH, CANVAS_HEIGHT);
        canvas1.setBackground(Color.WHITE);
        Graphics tools = canvas1.getGraphics();
        for (int i = 1; i < CANVAS_WIDTH; i = i + LINE_INC) {
            tools.setColor(new Color(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)));
            int x1 = (int) Math.round(Math.cos(2*Math.PI/CANVAS_WIDTH*i)*radius + CANVAS_WIDTH/2);
            int x2 = (int) Math.round(Math.cos(2*Math.PI/CANVAS_WIDTH*i + Math.PI*2/3)*radius + CANVAS_WIDTH/2);
            int x3 = (int) Math.round(Math.cos(2*Math.PI/CANVAS_WIDTH*i + Math.PI*4/3)*radius + CANVAS_WIDTH/2);
            int y1 = (int) Math.round(Math.sin(2*Math.PI/CANVAS_WIDTH*i)*radius + CANVAS_HEIGHT/2);
            int y2 = (int) Math.round(Math.sin(2*Math.PI/CANVAS_WIDTH*i + Math.PI*2/3)*radius + CANVAS_HEIGHT/2);
            int y3 = (int) Math.round(Math.sin(2*Math.PI/CANVAS_WIDTH*i + Math.PI*4/3)*radius + CANVAS_HEIGHT/2);
            int xPoints[] = {x1, x2, x3};
            int yPoints[] = {y1, y2, y3};
            int nPoints = 3;
            tools.drawPolygon(xPoints, yPoints, nPoints);
        }
    }
}
