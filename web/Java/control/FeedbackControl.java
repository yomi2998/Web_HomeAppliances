/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;
import domain.Feedback;
import da.FeedbackDA;
import java.util.List;
/**
 *
 * @author superme
 */
public class FeedbackControl {
    FeedbackDA feedbackDA;
    
    public FeedbackControl() {
        feedbackDA = new FeedbackDA();
    }
    
    public boolean insertFeedback(Feedback feedback) {
        return feedbackDA.insertFeedback(feedback);
    }
    
    public List<Feedback> retrieveFeedback(int user_id) {
        return feedbackDA.retrieveFeedback(user_id);
    }
    
    public boolean updateFeedback(Feedback feedback) {
        return feedbackDA.updateFeedback(feedback);
    }
    
    public void destroy() {
        feedbackDA.destroy();
    }
    
}
