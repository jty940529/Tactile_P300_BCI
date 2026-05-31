function [y_pred,y_score] = model4online(model,x_test,parModel)
test_features = apply_xdawn(x_test, parModel.W);
normalized_test = (test_features - parModel.mu) ./ parModel.sigma;
[y_pred, scores] = predict(model, normalized_test);
positive_class = 1;
class_order = model.ClassNames;
positive_idx = find(class_order == positive_class, 1);
y_score = scores(:, positive_idx);
end
