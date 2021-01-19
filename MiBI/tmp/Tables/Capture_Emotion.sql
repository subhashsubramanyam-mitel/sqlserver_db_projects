CREATE TABLE [tmp].[Capture_Emotion] (
    [CallRecording]   VARCHAR (50) NOT NULL,
    [PositiveEmotion] INT          NULL,
    [NegativeEmotion] INT          NULL,
    [NeutralEmotion]  INT          NULL,
    PRIMARY KEY CLUSTERED ([CallRecording] ASC)
);

