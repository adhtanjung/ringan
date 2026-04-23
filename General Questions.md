General Questions

**STRESS Decision-Tree**

## **🔹STRESS DECISION-TREE LOGIC (Q001–Q010)**

### **✅ Q001**

**“Do you often feel emotionally or mentally overwhelmed?”**

* **Yes** → Q002

* **No** → Q010

### **✅ Q002**

**“What tends to overwhelm or stress you most?”** *(multiple choice)*

* Relationship issues → **P004-1: Stress from Relationships**

* Family conflict or expectations → **P004-2: Stress from Family Relations**

* Bullying or social targeting → **P004-3: Stress from Bullying**

* Work or job stress → **P004-4: Stress from the Workplace**

* I can’t control my emotions → **P004-5: Emotional Dysregulation**

* Something traumatic just happened → **P004-6: Acute Stress Reaction**

* I feel like I’m not good enough → **P004-7: Stress from Low Self Esteem**

### **✅ Q010**

**“Would you say you are dealing with constant or background stress?”**

* **Yes** → Q002

* **No** → **Q011** *(routes to Anxiety)*

## **📊 STRESS Decision Tree Flow Table**

| question\_id | question\_text | response\_type | leads\_to\_category | leads\_to\_subcategory | next\_question\_if\_yes | next\_question\_if\_no |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Q001 | Do you often feel emotionally or mentally overwhelmed? | yes/no | Stress |  | Q002 | Q010 |
| Q002 | What tends to overwhelm or stress you most? | multiple choice | Stress |  |  |  |
| Q003 | Option: Relationship issues | auto-route | Stress | P004-1 Stress from Relationships |  |  |
| Q004 | Option: Family conflict | auto-route | Stress | P004-2 Stress from Family Relations |  |  |
| Q005 | Option: Bullying or social targeting | auto-route | Stress | P004-3 Stress from Bullying |  |  |
| Q006 | Option: Work or job pressure | auto-route | Stress | P004-4 Stress from the Workplace |  |  |
| Q007 | Option: Can’t control emotions | auto-route | Stress | P004-5 Emotional Dysregulation |  |  |
| Q008 | Option: Something traumatic happened | auto-route | Stress | P004-6 Acute Stress Reaction |  |  |
| Q009 | Option: Low self-worth / not good enough | auto-route | Stress | P004-7 Stress from Low Self Esteem |  |  |
| Q010 | Constant or background stress? | yes/no | Stress |  | Q002 | **Q011** |

## **🔹ANXIETY DECISION-TREE LOGIC (Q011–Q020)**

### **✅ Q011**

**“Do you often feel anxious, nervous, or on edge?”**

* **Yes** → Q012

* **No** → Q021 *(routes to Trauma)*

### **✅ Q012**

**“When do you usually feel the most anxious?”** *(multiple choice)*

* In social settings → **P001-1: Social Anxiety**

* Before or during exams or performance → **P001-2: Exam/Test Anxiety**

* During life transitions or change → **P001-3: Transition/Adjustment Anxiety**

* Out of nowhere, with intense fear → **P001-4: Panic Attacks (Disorder)**

* Constant mild worry → **P001-5: Generalized Anxiety – Mild**

* Worry affects focus and sleep → **P001-6: Generalized Anxiety – Moderate**

* I freeze, avoid, or shut down → **P001-7: Generalized Anxiety – Severe**

* I panic when separated from someone → **P001-8: Separation Anxiety**

## **📊 ANXIETY Decision Tree Flow Table**

| question\_id | question\_text | response\_type | leads\_to\_category | leads\_to\_subcategory | next\_question\_if\_yes | next\_question\_if\_no |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Q011 | Do you often feel anxious, nervous, or on edge? | yes/no | Anxiety |  | Q012 | Q021 |
| Q012 | When do you usually feel the most anxious? | multiple choice | Anxiety |  |  |  |
| Q013 | Option: In social settings or around people | auto-route | Anxiety | P001-1 Social Anxiety |  |  |
| Q014 | Option: Before/during tests or performance tasks | auto-route | Anxiety | P001-2 Exam/Test Anxiety |  |  |
| Q015 | Option: During life transitions or major changes | auto-route | Anxiety | P001-3 Transition/Adjustment Anxiety |  |  |
| Q016 | Option: Out of nowhere, intense panic or fear attacks | auto-route | Anxiety | P001-4 Panic Attacks (Disorder) |  |  |
| Q017 | Option: Constant mild worry | auto-route | Anxiety | P001-5 Generalized Anxiety – Mild |  |  |
| Q018 | Option: Worry affects sleep/focus | auto-route | Anxiety | P001-6 Generalized Anxiety – Moderate |  |  |
| Q019 | Option: I freeze or shut down from anxiety | auto-route | Anxiety | P001-7 Generalized Anxiety – Severe |  |  |
| Q020 | Option: Panic when separated from someone | auto-route | Anxiety | P001-8 Separation Anxiety |  |  |

## **🔹TRAUMA DECISION-TREE LOGIC (Q021–Q030)**

### **✅ Q021**

**“Have you experienced something recently or in the past that was deeply disturbing, frightening, or traumatic?”**

* **Yes** → Q022

* **No** → Q031 *(routes to Depression)*

### **✅ Q022**

**“When did the traumatic event(s) happen?”** *(multiple choice)*

* Very recently (days/weeks) → **P005-2: Acute Stress**

* Ongoing exposure (abuse, violence) → **P005-3: Chronic Trauma**

* In childhood or early life → **P005-4: Developmental Trauma**

* One specific event → **P005-1: Single-Incident Trauma**

* A while ago, but still affects me → **P005-5: Post-Traumatic Stress**

* Many traumas over time → **P005-6: Complex Trauma**

## **📊 TRAUMA Decision Tree Flow Table**

| question\_id | question\_text | response\_type | leads\_to\_category | leads\_to\_subcategory | next\_question\_if\_yes | next\_question\_if\_no |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Q021 | Have you experienced something recently or in the past that was traumatic? | yes/no | Trauma |  | Q022 | Q031 |
| Q022 | When did the traumatic event(s) happen? | multiple choice | Trauma |  |  |  |
| Q023 | Option: Very recently (last few days/weeks) | auto-route | Trauma | P005-2 Acute Stress |  |  |
| Q024 | Option: Ongoing exposure (violence, abuse, neglect) | auto-route | Trauma | P005-3 Chronic Trauma |  |  |
| Q025 | Option: Childhood trauma or early-life event | auto-route | Trauma | P005-4 Developmental Trauma |  |  |
| Q026 | Option: One single traumatic incident | auto-route | Trauma | P005-1 Single-Incident Trauma |  |  |
| Q027 | Option: Happened a while ago but still affects me | auto-route | Trauma | P005-5 Post-Traumatic Stress |  |  |
| Q028 | Option: I’ve experienced many traumas over time | auto-route | Trauma | P005-6 Complex Trauma |  |  |

## 

## **🔹DEPRESSION DECISION-TREE LOGIC (Q031–Q040)**

### **✅ Q031**

**“Are your main struggles more related to sadness, low mood, or lack of motivation?”**

* **Yes** → Q032

* **No** → Q041 *(routes to Grief & Loss)*

### **✅ Q032**

**“How would you describe your current emotional state?”** *(multiple choice)*

* I feel low occasionally but still function → **P002-1: Mild Depression**

* I feel persistently low, tired, or hopeless → **P002-2: Moderate Depression**

* I struggle to function or get out of bed → **P002-3: Severe Depression**

* I feel emotionally numb or disconnected → **P002-4: Dissociative Depression**

* My mood goes through cycles or bursts → **P002-5: Cyclical/Bipolar Depression**

* I’m grieving something or someone → **P002-6: Grief-related Depression**

* I feel empty or like I don’t matter → **P002-7: Existential Depression**

## **📊 DEPRESSION Decision Tree Flow Table**

| question\_id | question\_text | response\_type | leads\_to\_category | leads\_to\_subcategory | next\_question\_if\_yes | next\_question\_if\_no |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Q031 | Are your main struggles more related to sadness or low motivation? | yes/no | Depression |  | Q032 | Q041 |
| Q032 | How would you describe your emotional state? | multiple choice | Depression |  |  |  |
| Q033 | Option: Low occasionally, still functioning | auto-route | Depression | P002-1 Mild Depression |  |  |
| Q034 | Option: Persistent low mood and hopelessness | auto-route | Depression | P002-2 Moderate Depression |  |  |
| Q035 | Option: Struggle to do daily tasks | auto-route | Depression | P002-3 Severe Depression |  |  |
| Q036 | Option: Feeling emotionally numb or disconnected | auto-route | Depression | P002-4 Dissociative Depression |  |  |
| Q037 | Option: Mood swings / emotional cycles | auto-route | Depression | P002-5 Cyclical/Bipolar Depression |  |  |
| Q038 | Option: Grieving someone or something | auto-route | Depression | P002-6 Grief-related Depression |  |  |
| Q039 | Option: Feeling purposeless or invisible | auto-route | Depression | P002-7 Existential Depression |  |  |

**GRIEF & LOSS DECISION-TREE LOGIC (Q041–Q050)**

### **✅ Q041**

**“Have you lost someone or something important to you recently or in the past?”**

* **Yes** → Q042

* **No** → Q051 *(routes to Addictions)*

### **✅ Q042**

**“What type of loss have you experienced?”** *(multiple choice)*

* Loss of a loved one → **P006-1: Loss of Loved One**

* Loss of a role, identity, or future → **P006-2: Identity/Role Loss**

* Loss due to separation, divorce, job, etc. → **P006-3: Disenfranchised Loss**

* Long or stuck grief process → **P006-4: Complicated Grief**

## **📊 GRIEF & LOSS Decision Tree Flow Table**

| question\_id | question\_text | response\_type | leads\_to\_category | leads\_to\_subcategory | next\_question\_if\_yes | next\_question\_if\_no |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Q041 | Have you lost someone or something important? | yes/no | Grief and Loss |  | Q042 | Q051 |
| Q042 | What type of loss have you experienced? | multiple choice | Grief and Loss |  |  |  |
| Q043 | Option: Death of a loved one | auto-route | Grief and Loss | P006-1 Loss of Loved One |  |  |
| Q044 | Option: Identity or role loss | auto-route | Grief and Loss | P006-2 Identity/Role Loss |  |  |
| Q045 | Option: Loss due to job/divorce/separation | auto-route | Grief and Loss | P006-3 Disenfranchised Loss |  |  |
| Q046 | Option: Ongoing or stuck grief process | auto-route | Grief and Loss | P006-4 Complicated Grief |  |  |

## **🔹ADDICTIONS DECISION-TREE LOGIC (Q051–Q060)**

### **✅ Q051**

**“Have you been using substances or behaviors to escape, numb, or cope with pain?”**

* **Yes** → Q052

* **No** → \[End or alternate route\] *(can loop to identity, relationships, or offer a summary/next step)*

### **✅ Q052**

**“What type of coping or addictive pattern fits you best?”** *(multiple choice)*

* Alcohol or drug use → **P007-1: Substance Use**

* Behavioral patterns (gaming, porn, gambling) → **P007-2: Behavioral Addictions**

* Emotional attachment or dependency → **P007-3: Emotional Dependency**

* Using food, shopping, or screens to self-soothe → **P007-4: Self-Soothing Behaviors**

## **📊 ADDICTIONS Decision Tree Flow Table**

| question\_id | question\_text | response\_type | leads\_to\_category | leads\_to\_subcategory | next\_question\_if\_yes | next\_question\_if\_no |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Q051 | Have you been using substances or behaviors to numb or cope? | yes/no | Addictions |  | Q052 | \[END or redirect\] |
| Q052 | What type of coping/addictive pattern fits you best? | multiple choice | Addictions |  |  |  |
| Q053 | Option: Alcohol or drug use | auto-route | Addictions | P007-1 Substance Use |  |  |
| Q054 | Option: Gaming, porn, gambling, etc. | auto-route | Addictions | P007-2 Behavioral Addictions |  |  |
| Q055 | Option: Addicted to person or emotions | auto-route | Addictions | P007-3 Emotional Dependency |  |  |
| Q056 | Option: Use food/shopping/screens to soothe | auto-route | Addictions | P007-4 Self-Soothing Behaviors |  |  |

