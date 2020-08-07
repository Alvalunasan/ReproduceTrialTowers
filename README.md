# Reproduce Trial Towers

This is a small tool to generate "playback" videos for the Virtual Reality Towers Task.

## Prerequisities

* Clone **Datajoint Matlab**.
(https://github.com/datajoint/datajoint-matlab)

* Clone **U19-pipeline-matlab**
(https://github.com/BrainCOGS/U19-pipeline-matlab)

* Have read permission only in **TankMouseVR**
(https://github.com/BrainCOGS/U19-pipeline-matlab)

* Make sure you have a user set up for datajoint u19.

* To generate videos this tool has to be installed in a ViRMEn capable computer.


## How to use

### First steps

1. Add **Datajoint Matlab** to Matlab path
2. Add **U19-pipeline-matlab** to Matlab path
3. Add this repository **(ReproduceTrialTowers)** to Path
4. Create ReproduceTrialTowers object

`rtt = ReproduceTrialTowers()`

(User and password for datajoint needed here)

### To generate videos

1. Create a key as a reference to a **single session**.

```
key.subject_fullname = 'hnieh_E84'
key.session_date     = '2019-06-13
key

  struct with fields:

    subject_fullname: 'hnieh_E84'
        session_date: '2019-06-13'
```

2. Use ReproduceTrialTowers with the key to generate videos.

```
rtt.generateVideosSession(key)
```


### To retrieve videos

1. Create a key as a reference to a **single trial**.

```
key.subject_fullname = 'hnieh_E84'
key.session_date     = '2019-06-13'
key.block            = 2
key.trial_idx        = 1
key = 

  struct with fields:

    subject_fullname: 'hnieh_E84'
        session_date: '2019-06-13'
               block: 2
           trial_idx: 1

```



2. Use ReproduceTrialTowers with the key to retrieve video.

```
rtt.retrieveVideosTrial(key)
```
