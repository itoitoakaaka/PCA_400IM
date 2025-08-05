% エクセルファイルの読み込み
data = readtable('/Users/itoakane/Matlabfile/400im.xlsx');

% タイムデータの抽出
features = data.totalTime;

% K-meansクラスタリングによる2つのクラスターの作成
[idx, C] = kmeans(features, 2);

% クラスタの平均タイムを基にラベルを付ける
% 早い方のタイムをMenFinal、遅い方のタイムをWomenPrelimとする
labels = cell(size(idx)); % 初期化
if C(1) < C(2)
    labels(idx == 1) = {'MenFinal'};
    labels(idx == 2) = {'WomenPrelim'};
else
    labels(idx == 2) = {'MenFinal'};
    labels(idx == 1) = {'WomenPrelim'};
end
labels = categorical(labels);

% データの分割 (80% トレーニング, 20% テスト)
cv = cvpartition(labels, 'HoldOut', 0.2);
trainIdx = training(cv);
testIdx = test(cv);

trainFeatures = features(trainIdx, :);
trainLabels = labels(trainIdx);

testFeatures = features(testIdx, :);
testLabels = labels(testIdx);


% RBFカーネルを使用したSVMモデルのトレーニング
svmModel = fitcsvm(trainFeatures, trainLabels, 'KernelFunction', 'rbf');

% テストデータに対する予測
predictedLabels = predict(svmModel, testFeatures);

% モデルの性能評価
accuracy = sum(predictedLabels == testLabels) / length(testLabels);
disp(['Accuracy: ', num2str(accuracy * 100), '%']);

% 結果のプロット
figure;
hold on;

% すべてのデータポイントをプロット (トレーニングデータ)
gscatter(trainFeatures, trainLabels, trainLabels, 'br', 'xo');

% テストデータの実際のラベルと予測ラベルをプロット
gscatter(testFeatures, testLabels, testLabels, 'br', 'xo', 12);
gscatter(testFeatures, predictedLabels, predictedLabels, 'gm', '.*', 12);

xlabel('Total Time');
ylabel('Class Labels');
legend('Train MenFinal', 'Train WomenPrelim', 'Test Actual MenFinal', 'Test Actual WomenPrelim', 'Test Predicted MenFinal', 'Test Predicted WomenPrelim');
title('SVM with RBF Kernel Classification Results');
hold off;