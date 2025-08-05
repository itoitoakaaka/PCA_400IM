function w400im
    % ファイルパスを定義
    file_path = '/Users/itoakane/Matlabfile/w400im.xlsx';

    % エクセルファイルを読み込む
    data = readtable(file_path, 'VariableNamingRule', 'preserve');

  
    % PCAのために特定の列を選択する
    selected_columns = {'total time', 'sv15-45', 'sv65-95', 'sv115-145', 'sv165-195', ...
                        'sv215-245', 'sv265-295', 'sv315-345', 'sv365-395', ...
                        'st15-45', 'st65-95', 'st115-145', 'st165-195', ...
                        'st215-245', 'st265-295', 'st315-345', 'st365-395', ...
                        'sl15-45', 'sl65-95', 'sl115-145', 'sl165-195', ...
                        'sl215-245', 'sl265-295', 'sl315-345', 'sl365-395', ...
                        'sc15-45', 'sc65-95', 'sc115-145', 'sc165-195', ...
                        'sc215-245', 'sc265-295', 'sc315-345', 'sc365-395'};
    % total time列のインデックスを取得する
total_time_index = find(strcmp(data.Properties.VariableNames, 'total time'));

% total time列を除いた特徴量の列を定義する
feature_columns = data.Properties.VariableNames;
feature_columns = feature_columns(~strcmp(feature_columns, 'total time'));

    % 特徴量行列 X を準備する
    X = data{:, selected_columns};

    % データを標準化する
    X = normalize(X);

    % PCA を実行する
    [coeff, score, latent, tsquared, explained, mu] = pca(X);

  
% total time に対する主成分の寄与率を取得する
total_time_contribution = coeff(total_time_index, :);

% total time に対する各主成分の寄与率を表示する
fprintf('total time に対する各主成分の寄与率:\n');
disp(total_time_contribution);

% total time列に対する寄与率を計算する
total_time_contribution = coeff(:, 1); % 最初の主成分（PC1）の係数

% PCAを実行した後のコード
[coeff, score, latent, tsquared, explained, mu] = pca(X);

% total time列に対する寄与率を計算する
total_time_contribution = coeff(:, 1); % 最初の主成分（PC1）の係数

% 特徴量のラベル（IDを除外）
feature_labels = {'total time', 'sv15-45', 'sv65-95', 'sv115-145', 'sv165-195', ...
    'sv215-245', 'sv265-295', 'sv315-345', 'sv365-395', 'st15-45', 'st65-95', ...
    'st115-145', 'st165-195', 'st215-245', 'st265-295', 'st315-345', 'st365-395', ...
    'sl15-45', 'sl65-95', 'sl115-145', 'sl165-195', 'sl215-245', 'sl265-295', ...
    'sl315-345', 'sl365-395', 'sc15-45', 'sc65-95', 'sc115-145', 'sc165-195', ...
    'sc215-245', 'sc265-295', 'sc315-345', 'sc365-395'};

% ID列を除外する
total_time_contribution_no_id = total_time_contribution(2:end);

% 寄与率が高い順にソートする
[sorted_contributions, idx] = sort(abs(total_time_contribution_no_id), 'descend');
sorted_features = feature_labels(idx);

% 表示する
fprintf('total timeへの寄与率が高い項目:\n');
for i = 1:length(sorted_features)
    fprintf('%s: %.4f\n', sorted_features{i}, sorted_contributions(i));
end

% total time列に対する最初の主成分の寄与率をプロットする
figure;
bar(sorted_contributions);
xlabel('特徴量');
ylabel('寄与率');
title('最初の主成分に対するtotal timeの寄与率');
grid on;

% 特徴量のラベルを表示するためのコード（必要に応じて）
xticks(1:length(sorted_features));
xticklabels(sorted_features);
xtickangle(45); % ラベルを45度回転して表示する