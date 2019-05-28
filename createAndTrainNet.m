function net = createAndTrainNet(XTrain,YTrain,numWords)
inputSize = size(XTrain{1},1);
numClasses = numel(categories([YTrain{:}]));

layers = [sequenceInputLayer(inputSize)
          wordEmbeddingLayer(300,numWords)
          lstmLayer(400,'OutputMode','sequence')
          dropoutLayer(0.2)
          fullyConnectedLayer(numClasses)
          softmaxLayer
          classificationLayer];
      
options = trainingOptions('adam', ...
    'MiniBatchSize',32,...
    'ExecutionEnvironment','cpu',...
    'InitialLearnRate',0.01, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Plots','training-progress', ...
    'Verbose',false);

net = trainNetwork(XTrain,YTrain,layers,options);
end